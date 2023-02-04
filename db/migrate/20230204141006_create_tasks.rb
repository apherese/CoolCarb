class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :name
      t.references :footprint, null: false, foreign_key: true
      t.integer :ghg_contribution
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
