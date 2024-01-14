# frozen_string_literal: true

class PlanningJob
  include Sidekiq::Job

  def perform(*args)
    # Do something
    SetupService.new({meta: {id: args[:plan_id]}, data: JSON.parse(plan.planning_information, symbolize_names: true)}).call
    if true
      # 一番最初に「移動可能なロボット」を検索して、すべてのノードを網羅するロジックを利用
      PlanningService.new({id: args[:plan_id]}).call
    else
      # 一番最初に「近場のノードで作業を完了するロボット」を検索して、すべてのノードを網羅するロジックを利用
      PlanningMinWorkingService.new({id: args[:plan_id]}).call
    end
  end
end
