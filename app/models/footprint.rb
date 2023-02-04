class Footprint < ApplicationRecord
  belongs_to :company
  has_many :tasks, dependent: :destroy
end
