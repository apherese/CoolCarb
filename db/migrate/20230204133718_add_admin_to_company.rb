class AddAdminToCompany < ActiveRecord::Migration[7.0]
  def change
    change_table :companies do |t|
      t.references :admin, foreign_key: { to_table: "users" }
    end
  end
end
