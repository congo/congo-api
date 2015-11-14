class Api::ApiExternalController < ::ExternalController
  before_filter :check_maintenance

  def check_maintenance
    if ENV['MAINTENANCE'] == 'true'
      render :json => {
        maintenance: true
      }
    end
  end
end

