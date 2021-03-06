class Api::Internal::Admin::BenefitPlansController < ::Api::ApiController
  protect_from_forgery

  before_filter :ensure_admin!

  def index
    benefit_plans = BenefitPlan.all

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
    carrier_id = params[:carrier_id]
    carrier = Carrier.where(id: carrier_id).first
    properties = params[:properties]
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
      account_id: nil,
      carrier_id: carrier.id,
      properties: properties,
      description_markdown: description_markdown,
      description_html: description_html

    respond_to do |format|
      format.json {
        render json: {
          benefit_plan: render_benefit_plan(benefit_plan)
        }
      }
    end
  end

  def update
    benefit_plan = BenefitPlan.where(slug: params[:id]).first
    properties = params[:properties]

    unless benefit_plan
      # TODO: Test this
      error_response('Could not find a matching benefit plan.')
      return
    end

    # Only modify `is_enabled` if it is passed as a parameter.
    unless params[:is_enabled].nil?
      benefit_plan.update_attributes! \
        is_enabled: params[:is_enabled]
    end

    # Only modify `properties` if it is passed as a parameter.
    unless properties.nil?
      name = properties['name']
      description_markdown = properties['description_markdown']
      description_html = properties['description_html']
      carrier_account_id = properties['carrier_account_id'].to_i

      benefit_plan.update_attributes! \
        name: name,
        carrier_account_id: carrier_account_id,
        properties: properties,
        description_markdown: description_markdown,
        description_html: description_html
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
    benefit_plan = BenefitPlan.where(slug: params[:id]).first

    respond_to do |format|
      format.json {
        render json: {
          benefit_plan: render_benefit_plan(benefit_plan)
        }
      }
    end
  end

  def destroy
    benefit_plan = BenefitPlan.where(slug: params[:id]).first

    benefit_plan.destroy!

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
    account = carrier_account.try(:account)
    carrier = carrier_account.try(:carrier)
    carrier_account_hash = carrier_account.try(:as_json) || {}

    benefit_plan.as_json.merge({
      'account' => benefit_plan.account,
      'carrier_account' => carrier_account_hash.merge({
        'account' => account,
        'carrier' => carrier
      }),
      'attachments' => benefit_plan.attachments
    })
  end
end

