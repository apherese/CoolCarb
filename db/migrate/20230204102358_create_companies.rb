class CreateCompanies < ActiveRecord::Migration[7.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :industry
      t.integer :employee_nb
      t.integer :kwh
      t.integer :square_meter

      t.timestamps
    end
  end
end
