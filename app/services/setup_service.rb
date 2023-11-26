class SetupService
  attr_reader :params, :plan

  def initialize(params)
    @params = params[:data]
    @plan = Plan.find_by(plan_id: @params[:meta][:id])
  end

  def call
  end

  private

  # params = {
  # "data":{
  #   "nodes": [
  #    {
  #      "id": "1",
  #      "coordinates": {
  #        "latitude": 1.0,
  #        "longitude": 1.0,
  #      },
  #      "time_required": 1,
  #   ],
  #   "robots": [
  #     {
  #       "id": "1",
  #       "coordinates": {
  #         "latitude": 1.0,
  #         "longitude": 1.0,
  #       },
  #       "start_time": "2023-11-22T00:11:22+09:00",
  #     },
  #   ],
  #   "areas": [
  #     {
  #       "id": "1",
  #       "coordinates": {
  #         "latitude": 1.0,
  #         "longitude": 1.0,
  #       },
  #       "radius": 16.0,
  #       "robots": ["1"],
  #     },
  #   ],
  # },
  # },
  # "meta": {
  #    "id": "hoge-fuga"
  # }
  #

  def register_nodes
    params[:nodes].each do |e|
      plan.nodes.create(
        node_id: e[:id],
        position: "POINT(#{e[:coordinates][:latitude]} #{e[:coordinates][:longitude]})",
        time_required: e[:time_required],
      )
    end
  end

  def register_robot
    params[:robots].each do |e|
      plan.robots.create(
        robot_id: e[:id],
        position: "POINT(#{e[:coordinates][:latitude]} #{e[:coordinates][:longitude]})",
        start_time: e[:start_time],
      )
    end
  end

  def register_area
    params[:areas].each do |e|
      plan.areas.create(
        area_id: e[:id],
        position: "POINT(#{e[:coordinates][:latitude]} #{e[:coordinates][:longitude]})",
        radius: e[:radius],
      )
    end
  end

  def register_line
    list = plan.nodes.to_a
    while (n = list.shift).present?
      CalcDistanceService.new(n, list).each do |e|
        plan.lines.create(
          from: e[:from],
          to: e[:to],
          distance: e[:distance],
        )
      end
    end
  end
end
