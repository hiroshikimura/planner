class CreateAreas < ActiveRecord::Migration[7.1]
  def change
    create_table :areas do |t|
      t.references :plan, null: false, foreign_key: true
      t.string :area_id, null: false
      t.geometry :position, null: false, index: true
      t.float :radius, null: false

      t.timestamps
    end
  end
end
