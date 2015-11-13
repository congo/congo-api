class ApplicationController < ActionController::API
  include ActionController::Serialization
  include ActionController::RequestForgeryProtection
  include UsersHelper
end

