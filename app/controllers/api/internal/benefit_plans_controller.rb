class Api::Internal::BenefitPlansController < ApplicationController
  protect_from_forgery

  before_filter :ensure_user!
  before_filter :ensure_account!
  before_filter :ensure_broker_or_group_admin!, only: [:create, :update, :destroy]

  def index
    account_slug = params[:account_id]
    account = Account.where(slug: account_slug).first
    role_slug = params[:role_id]
    only_activated_carriers = (params[:only_activated_carriers] == 'true')
    only_activated = (params[:only_activated] == 'true')
    benefit_plans = nil

    if only_activated_carriers
      benefit_plans = CarrierAccount
        .where('account_id = ?', current_account.id)
        .includes(:carrier => :benefit_plans)
        .map(&:carrier)
        .map(&:benefit_plans)
        .flatten(1)
    elsif only_activated
      benefit_plans = AccountBenefitPlan
        .where('account_id = ?', current_account.id)
        .includes(:benefit_plan)
        .map(&:benefit_plan)
    else
      benefit_plans = BenefitPlan
        .where('account_id IS NULL or account_id = ?', current_account.id)
    end

    if role_slug != 'group_admin' && role_slug != 'broker'
      benefit_plans.select { |benefit_plan|
        benefit_plan.is_enabled == true
      }
    end

    benefit_plans = benefit_plans.reject { |benefit_plan|
      # Do not show admin-created benefit plans which are not enabled.
      benefit_plan.account_id == nil && benefit_plan.is_enabled == false
    }

    respond_to do |format|
      format.json {
        render json: {
          benefit_plans: benefit_plans.map { |benefit_plan|
            render_benefit_plan(benefit_plan)
          }
        }
      }
    end
  end

  def show
    benefit_plan = BenefitPlan
      .where('account_id IS NULL or account_id = ?', current_account.id)
      .where(slug: params[:id])
      .first

    respond_to do |format|
      format.json {
        render json: {
          benefit_plan: render_benefit_plan(benefit_plan)
        }
      }
    end
  end

  def create
    name = params[:name]
    carrier_id = params[:carrier_id]
    carrier = Carrier.where(id: carrier_id).first
    carrier_account = carrier.carrier_accounts.where(account_id: current_account.id).first
    properties = params[:properties]
    account_benefit_plan_properties = params[:account_benefit_plan_properties]
    description_markdown = properties['description_markdown']
    description_html = properties['description_html']

    unless name
      # TODO: Test this
      error_response('Name must be provided.')
      return
    end

    unless carrier
      # TODO: Test this
      error_response('Could not find a matching carrier.')
      return
    end

    benefit_plan = BenefitPlan.create! \
      name: name,
      account_id: current_account.id,
      carrier_id: carrier.id,
      properties: properties,
      description_markdown: description_markdown,
      description_html: description_html

    account_benefit_plan = AccountBenefitPlan.create! \
      account_id: current_account.id,
      carrier_id: carrier.id,
      carrier_account_id: carrier_account.try(:id),
      benefit_plan_id: benefit_plan.id,
      properties: account_benefit_plan_properties

    respond_to do |format|
      format.json {
        render json: {
          benefit_plan: render_benefit_plan(benefit_plan)
        }
      }
    end
  end

  def update
    benefit_plan = BenefitPlan
      .where('account_id IS NULL or account_id = ?', current_account.id)
      .where(slug: params[:id])
      .first
    account_benefit_plan = AccountBenefitPlan.where(benefit_plan_id: benefit_plan.id, account_id: current_account.id).first
    carrier = benefit_plan.carrier
    carrier_account = CarrierAccount.where(account_id: current_account.id, carrier_id: carrier.id).first
    properties = params[:properties]
    account_benefit_plan_properties = params[:account_benefit_plan_properties]
    name = properties['name']
    description_markdown = properties['description_markdown']
    description_html = properties['description_html']

    if benefit_plan.account_id == current_account.id
      # Only modify `properties` if it is passed as a parameter.
      unless properties.nil?
        benefit_plan.update_attributes! \
          name: name,
          properties: properties,
          description_markdown: description_markdown,
          description_html: description_html
      end

      # Only modify `is_enabled` if it is passed as a parameter.
      unless params[:is_enabled].nil?
        benefit_plan.update_attributes! \
          :is_enabled, params[:is_enabled]
      end
    end

    account_benefit_plan ||= AccountBenefitPlan.create! \
      account_id: current_account.id,
      carrier_id: carrier.id,
      carrier_account_id: carrier_account.try(:id),
      benefit_plan_id: benefit_plan.id

    # Only modify `account_benefit_plan_properties` if it is passed as a parameter.
    unless account_benefit_plan_properties.nil?
      account_benefit_plan.update_attributes! \
        properties: account_benefit_plan_properties
    end

    respond_to do |format|
      format.json {
        render json: {
          benefit_plan: render_benefit_plan(benefit_plan)
        }
      }
    end
  end

  def destroy
    benefit_plan = BenefitPlan
      .where('account_id IS NULL or account_id = ?', current_account.id)
      .where(slug: params[:id])
      .first
    account_benefit_plan = AccountBenefitPlan.where(benefit_plan_id: benefit_plan.id, account_id: current_account.id).first

    if benefit_plan.account_id == current_account.id
      benefit_plan.try(:destroy!)
    end

    account_benefit_plan.try(:destroy!)

    respond_to do |format|
      format.json {
        render json: {
          benefit_plan: render_benefit_plan(benefit_plan)
        }
      }
    end
  end

  # Render methods

  def render_benefit_plan(benefit_plan)
    # NOTE: Carrier account may be nil if it was deleted by the user.
    carrier_account = benefit_plan.carrier_account
    account = benefit_plan.account
    carrier = benefit_plan.carrier
    account_benefit_plan = benefit_plan.account_benefit_plan
    attachments = benefit_plan.attachments

    benefit_plan.as_json.merge({
      'carrier' => carrier,
      'account' => account,
      'carrier_account' => carrier_account,
      'account_benefit_plan' => account_benefit_plan,
      'attachments' => attachments
    })
  end
end

