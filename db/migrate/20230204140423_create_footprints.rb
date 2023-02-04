class CreateFootprints < ActiveRecord::Migration[7.0]
  def change
    create_table :footprints do |t|
      t.json :ghg_result
      t.string :step
      t.boolean :certified
      t.date :date
      t.integer :ghg_target
      t.integer :target_year
      t.boolean :target_commitment

      t.timestamps
    end
  end
end
