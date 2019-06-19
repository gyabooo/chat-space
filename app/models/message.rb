class Message < ApplicationRecord
  belongs_to :group
  belongs_to :user
  mount_uploader :image, MessageImageUploader
  validates :image, presence: true, unless: Proc.new { |a| a.body.present? }
  # validates :body, presence: true
end
