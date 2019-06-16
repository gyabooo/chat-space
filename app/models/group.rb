class Group < ApplicationRecord
  has_many :users, through: :members
  has_many :messages
  has_many :members
end
