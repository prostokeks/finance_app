class Category < ApplicationRecord
  belongs_to :user

  has_many :operations

  paginates_per 10

  #scope :all_self_user,->{ where(user_id: 1) }
  validates :name, :description, presence: true
  validates :name, length: {maximum: 30}
  validates :description, length: {in: 10..200}

end
