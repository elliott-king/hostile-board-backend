class Position < ApplicationRecord
  has_many :applications
  belongs_to :company
end
