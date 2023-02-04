class MoveCompanyAdminToUserTable < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :admin, :boolean, default: false, null: false
    remove_column :companies, :admin_id
  end
end
