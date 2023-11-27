# frozen_string_literal: true

class PlanningService
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def call; end
end
