class Company < ApplicationRecord
  has_many :positions
  has_many :applications, :through => :positions
end
