class Company < ApplicationRecord
  has_many :positions
  has_many :applications, :through => :positions
  belongs_to :user
  has_many :messages
end
