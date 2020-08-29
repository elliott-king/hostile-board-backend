class User < ApplicationRecord
  has_many :applications
  has_one :company
  has_many :messages
  has_one_attached :resume

  def resume_url
    if resume.attached?
      resume.blob.service_url
    end
  end
end
