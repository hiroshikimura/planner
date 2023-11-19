class SetupService
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def call
  end

  private

  # params =
  # {
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
  #       "radius": 1,
  #       "robots": ["1"],
  #     },
  #   ],
  # }
  #
  #

  def register_nodes
  end

  def register_robot
  end

  def register_area
  end

  def register_line
  end
end
