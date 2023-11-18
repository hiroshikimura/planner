# frozen_string_literal: true

class RodauthController < ApplicationController
  before_action :authenticate

  private

  def authenticate
    rodauth.require_account
  end
end
