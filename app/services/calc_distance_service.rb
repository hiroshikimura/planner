class CalcDistanceService

  def self.calculate_distance(point, points)
    # pointとpointsそれぞれの距離を算出する
    # この方法は簡易な方法であり、道路やその状況を考慮していない
    n1_table_name = points.first.class.table_name
    n2_table_name = point.class.table_name
    q = <<~EOL_SQL.squish
      SELECT
        n1.id AS points_id,
        n2.id AS point_id,
        st_distance_sphere(n1.point, n2.point) AS distance
      FROM #{n1_table_name} AS n1
      INNER JOIN #{n2_table_name} AS n2
      ON n2.id = :point_id AND n1.id IN (:point_ids)
      WHERE n1.id IN (:point_ids)
    EOL_SQL
    point.class.find_by_sql([q, { point_id: point.id, point_ids: points.map(&:id) }]).map do |e|
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
