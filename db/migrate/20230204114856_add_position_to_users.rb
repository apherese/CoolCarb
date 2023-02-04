class AddPositionToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :position, :string
    add_column :users, :name, :string
    add_reference :users, :company, foreign_key: true
  end
end
