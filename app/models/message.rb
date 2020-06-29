class Message < ApplicationRecord
  belongs_to :company
  belongs_to :user
  belongs_to :position
end
