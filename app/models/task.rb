class Task < ApplicationRecord
  belongs_to :footprint
  belongs_to :owner, class_name: "User"
end
