class Group < ApplicationRecord
  has_many :messages
  has_many :members
  has_many :users, through: :members
  validates :name, presence: true, uniqueness: true

  def show_last_message_body
    if (last_message = messages.last).present?
      last_message.body if last_message.body?
    else
      'まだメッセージはありません。'
    end
  end

  def show_last_message_img
    if (last_message = messages.last).present?
      last_message.image.present? ? ActionController::Base.helpers.image_tag(last_message.image.url(:thumb)) : ''
    end
  end
end
