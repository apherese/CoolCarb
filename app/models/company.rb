class Company < ApplicationRecord
  has_many :users
  has_many :footprints
  has_one :user, as: :admin
end
