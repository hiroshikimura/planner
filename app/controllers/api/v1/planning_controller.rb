class Api::V1::PlanningController < ApplicationController
  def request
    # post
    plan = Plan.new_job(params)

    # 計画のIDを返却
    render json: { id: plan.job_id }
  end

  def result
    plan = Plan.find_by(job_id: params[:id])
    if plan.blank?
      # そもそもない
      render jsob: { }, status: :not_found
      return
    end

    if plan.planned_at.blank?
      # 計画中
      render json: { id: plan.job_id, status: "planning" }, status: :ok
      return
    end

    # 計画完了
    render json: {
      id: plan.job_id,
      status: 'completed',
      completed_at: plan.planned_at.iso8601,
      result: plan.ways.map { |w| { robot_id: w.robot_id, node_id: w.node_id, arrival_at: w.arrival_at, leave_at: w.leave_at } }
    }, status: :ok
  end
end
