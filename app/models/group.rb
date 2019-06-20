class Group < ApplicationRecord
  has_many :messages
  has_many :members
  has_many :users, through: :members
  validates :name, presence: true, uniqueness: true

  def show_last_message
    if (last_message = messages.last).present?
      result = []
      result.push last_message.body if last_message.body?
      result.push ActionController::Base.helpers.image_tag(last_message.image.url(:thumb)) if last_message.image.present?
      return result
    else
      ['まだメッセージはありません。']
    end
  end

end
