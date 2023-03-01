class AddLengthOfStayToCompanies < ActiveRecord::Migration[7.0]
  def change
    add_column :companies, :length_of_stay, :float, default: 2, null: false
  end
end
