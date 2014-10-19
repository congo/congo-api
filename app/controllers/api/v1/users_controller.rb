class Api::V1::UsersController < ApplicationController
  include ApplicationHelper

  def create
    first_name = params[:first_name]
    last_name = params[:last_name]
    email = params[:email]
    password = params[:password]
    password_confirmation = params[:password_confirmation]
    type = params[:type]
    email_token = params[:email_token]

    if password != password_confirmation
      # TODO: Handle this
    end

    user = User.create! \
      first_name: first_name,
      last_name: last_name,
      email: email,
      password: password,
      roles: [type]

    # User came in from an email and is therefore a customer
    if email_token
      membership = Membership.where(email_token: email_token).first
      membership.user_id = user.id
      membership.save!
    end

    signin! email, password

    respond_to do |format|
      format.json {
        render json: {
          user: user.simple_hash
        }
      }
    end
  end

  def update
    id = params[:id]
    user = User.where(id: id).first
    plan_name = params[:plan_name]
    card_number = params[:card_number]
    month = params[:month]
    year = params[:year]
    cvc = params[:cvc]
    account_name = params[:account_name]
    account_tagline = params[:account_tagline]
    properties = user.properties || {}
    account = nil

    properties['plan_name'] = plan_name if plan_name
    properties['card_number'] = card_number if card_number
    properties['month'] = month if month
    properties['year'] = year if year
    properties['cvc'] = cvc if cvc

    user.properties = properties
    user.save!

    if account_name || account_tagline
      if account_name
        account = Account.create! \
          name: account_name,
          tagline: account_tagline

        account_user = AccountUser.create! \
          account_id: account.id,
          user_id: user.id
      else
        render nothing: true, status: :unauthorized
        return
      end
    end

    respond_to do |format|
      format.json {
        render json: user.simple_hash
      }
    end
  end

  def signin
    email = params[:email]
    password = params[:password]

    begin
      user = signin! email, password

      respond_to do |format|
        format.json {
          render json: user.simple_hash
        }
      end
    rescue AuthenticationException => e
      render nothing: true, status: :unauthorized
    end
  end

  def signout
    signout!

    render nothing: true
  end
end

