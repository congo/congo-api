class Api::V1::BenefitPlansController < ApplicationController
  def index
    account_slug = params[:account_id]
    account = Account.where(slug: account_slug).first
    role_slug = params[:role_id]
    benefit_plans = nil

    if role_slug == 'group_admin' || role_slug == 'broker'
      benefit_plans = BenefitPlan.where(account_id: account.id)
    else
      benefit_plans = BenefitPlan.where(account_id: account.id, is_enabled: true)
    end

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

  def create
    name = params[:name]
    account_slug = params[:account_id]
    account = Account.where(slug: account_slug).first
    carrier_account_id = params[:carrier_account_id]
    carrier_account = CarrierAccount.where(id: carrier_account_id, account_id: account.id).first
    properties = params[:properties]

    unless name
      # TODO: Handle this
    end

    unless account
      # TODO: Handle this
    end

    unless carrier_account
      # TODO: Handle this
    end

    benefit_plan = BenefitPlan.create! \
      name: name,
      account_id: account.id,
      carrier_account_id: carrier_account.id,
      properties: properties

    respond_to do |format|
      format.json {
        render json: {
          benefit_plan: render_benefit_plan(benefit_plan)
        }
      }
    end
  end

  def update
    benefit_plan = BenefitPlan.find(params[:id])

    unless params[:is_enabled].nil?
      benefit_plan.update_attribute(:is_enabled, params[:is_enabled])
    end

    respond_to do |format|
      format.json {
        render json: {
          benefit_plan: render_benefit_plan(benefit_plan)
        }
      }
    end
  end

  def show
    id = params[:id]
    account_slug = params[:account_id]
    account = Account.where(slug: account_slug).first
    benefit_plan = BenefitPlan.where(id: params[:id]).first

    respond_to do |format|
      format.json {
        render json: {
          benefit_plan: render_benefit_plan(benefit_plan)
        }
      }
    end
  end

  def destroy
    id = params[:id]

    benefit_plan = BenefitPlan.find(id).destroy

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
    carrier_account = benefit_plan.carrier_account

    benefit_plan.as_json.merge({
      'carrier_account' => carrier_account.as_json.merge({
        'account' => carrier_account.account,
        'carrier' => carrier_account.carrier
      })
    })
  end
end

