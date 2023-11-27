# frozen_string_literal: true

class PlanningJob
  include Sidekiq::Job

  def perform(*args)
    # Do something
  end
end
