class User < ApplicationRecord
  has_many :applications
  has_one :company
end
