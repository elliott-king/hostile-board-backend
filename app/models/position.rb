class Position < ApplicationRecord
  has_many :applications
  belongs_to :company
  has_many :messages
end
