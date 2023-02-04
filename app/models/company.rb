class Company < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :footprints, dependent: :nullify
  belongs_to :admin, class_name: "User", optional: true
end
