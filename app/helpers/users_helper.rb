module UsersHelper
  include ApplicationHelper

  class AuthenticationException < StandardError
  end

  def signin!(email, password)
    user = User.find_by_email(email)

    raise AuthenticationException unless user
    raise AuthenticationException unless user.password_token.blank?
    raise AuthenticationException unless user.password == password

    @current_user = user
    session[:current_user_id] = user.id

    user
  end

  def crystal_ball!(id)
    user = User.find(id)

    raise AuthenticationException unless current_user
    raise AuthenticationException unless current_user.admin?

    @current_user = user
    session[:current_user_id] = user.id

    user
  end

  def signout!
    @current_user = nil
    session[:current_user_id] = nil
  end

  def admin?
    current_user && current_user.admin?
  end

  def current_user
    @current_user ||= User.where(id: session[:current_user_id]).first
  end

  def current_account
    if admin? && params[:account_id].nil?
      @current_account ||= Account.where(slug: 'admin').first
      return @current_account
    end

    @current_account ||= Account.where(slug: params[:account_id]).first
  end

  def current_role
    if admin? && params[:role_id].nil?
      @current_role ||= Role.where(name: 'admin').first
      return @current_role
    end

    @current_role ||= Role
      .where(
        name: params[:role_id],
        account_id: current_account.id,
        user_id: current_user.id
      )
      .first
  end

  def ensure_user!
    unless current_user
      error_response('You must be signed in.')
      return
    end
  end

  def ensure_account!
    unless current_account
      error_response('Could not find a matching account.')
      return
    end

    unless current_user.roles.map(&:account).include?(current_account)
      error_response('User does not have access to this account.')
    end
  end

  def ensure_admin!
    unless admin?
      error_response('You must be an admin to continue.')
      return
    end
  end

  def ensure_broker!
    unless current_role && current_role.name == 'broker'
      error_response('You must be a broker to continue.')
      return
    end
  end

  def ensure_broker_or_group_admin!
    # Skip if admin
    if current_role && current_role.name == 'admin'
      return
    end

    unless current_role && (current_role.name == 'broker' || current_role.name == 'group_admin')
      error_response('You must be a broker or group admin to continue.')
      return
    end
  end

  # Make sure the user is totally signed up
  def ensure_signed_up!
    # current_user
  end

  # Render methods

  def render_user(user)
    return nil unless user

    groups = Membership
      .where(user_id: current_user.id)
      .includes(:group)
      .map(&:group)
      .compact
      .select(&:is_enabled)

    accounts = user
      .roles
      .includes(:account)
      .map { |role|
        enabled_groups = groups
          .select { |group| group.account_id == role.account.id }

        first_enabled_group = enabled_groups.first

        role.account.as_json.merge({
          'role' => role,
          'enabled_features' => role.account.enabled_features.map(&:name),
          'message_count' => role.message_count,
          'activity_count' => role.activity_count,
          'enabled_group_count' => enabled_groups.count,
          'first_enabled_group' => first_enabled_group.as_json,
          'enabled_groups' => enabled_groups
        })
      }

    user
      .as_json({
        except: [:encrypted_password]
      })
      .merge({
        'is_admin' => user.admin?,
        'accounts' => accounts
      })
  end
end

