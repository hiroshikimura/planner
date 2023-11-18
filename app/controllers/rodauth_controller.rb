class RodauthController < ApplicationController
  # used by Rodauth for rendering views, CSRF protection, and running any
  # registered action callbacks and rescue_from handlers
  before_action :authenticate

  private

  def authenticate
    rodauth.require_account
  end

end
