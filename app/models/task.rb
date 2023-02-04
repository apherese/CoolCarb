class Task < ApplicationRecord
  belongs_to :footprints
  belongs_to :owner, class_name: "User"
end
