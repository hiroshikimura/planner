class CalcDistanceService
  attr_reader :point, :points

  def initialize(point, points)
    @point = point
    @points = points
  end

  def calculate_distance
    # pointとpointsそれぞれの距離を算出する
    # この方法は簡易な方法であり、道路やその状況を考慮していない
    q = <<~EOL_SQL.squish
      SELECT
        n1.id AS points_id,
        n2.id AS point_id,
        st_distance_sphere() AS distance
      FROM nodes AS n1
      INNER JOIN nodes AS n2
      ON n2.id = :point_id AND n1.id IN (:point_ids)
      WHERE n1.id IN (:point_ids)
    EOL_SQL
    Node.find_by_sql([q, { point_id: point.id, point_ids: points.map(&:id) }]).map do |e|
      {
        to: e.points_id,
        distance: {
          from: e.distance,
          to: e.distance
        }
      }
    end
  end
end
