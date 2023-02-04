class Task < ApplicationRecord
  belongs_to :footprints
  belongs_to :user, as: :owner
end
