# frozen_string_literal: true

class PlanningJob
  include Sidekiq::Job

  def perform(*args)
    # Do something
    SetupService.new({meta: {id: args[:plan_id]}, data: JSON.parse(plan.planning_information, symbolize_names: true)}).call
    PlanningService.new({id: args[:plan_id]}).call
  end
end
