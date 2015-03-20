class Api::Internal::AccountsController < ApplicationController
  protect_from_forgery

  before_filter :ensure_user!
  before_filter :ensure_account!
  before_filter :ensure_broker!

  def update
    account_slug = params[:account_id]
    account = Account.where(slug: account_slug).first

    unless account
      error_response('Could not find a matching account.')
      return
    end

    properties = params[:properties]

    # TODO: Make sure name is unique

    name = properties['name']
    tagline = properties['tagline']
    tax_id = properties['tax_id']
    first_name = properties['first_name']
    last_name = properties['last_name']
    phone = properties['phone']
    plan_name = properties['plan_name']

    if name.present?
      account.name = name
    end

    if tagline
      account.tagline = tagline
    end

    if Account::PLAN_NAMES.include?(plan_name)
      account.plan_name = plan_name
    end

    account.properties = properties
    account.save!

    respond_to do |format|
      format.json {
        render json: {
          user: render_user(current_user)
        }
      }
    end
  end
end

