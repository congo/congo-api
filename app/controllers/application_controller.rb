class ApplicationController < ActionController::Base
  include ActionController::Serialization
  include ActionController::RequestForgeryProtection
  include UsersHelper
end

