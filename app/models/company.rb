class Company < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :footprints, dependent: :nullify
  belongs_to :admin, class_name: "User", optional: true

  scope :sector, ->(industry) { where(industry: industry) }
  validates :name, :industry, :employee_nb, :room_nb, :length_of_stay, :load_factor, presence: true
  validates :room_nb, numericality: { only_integer: true, greater_than: 0 }
  validates :length_of_stay, numericality: { greater_than_or_equal_to: 1 }
end
