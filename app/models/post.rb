class Post < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true, length: { minimum: 5, maximum: 500 }
  belongs_to :player
  validates :player_id, presence: true
  default_scope -> { order(updated_at: :desc) }
  has_many :post_items
  has_many :items, through: :post_items
  has_many :comments, dependent: :destroy
end
