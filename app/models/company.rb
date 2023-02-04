class Company < ApplicationRecord
  has_many :users
  has_many :footprints
  belongs_to :admin, class_name: "User"
end
