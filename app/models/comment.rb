class Comment < ApplicationRecord
  validates :description, presence: true, length: { minimum: 4, maximum: 140 }
  belongs_to :player
  belongs_to :post
  validates :player_id, presence: true
  validates :post_id, presence: true
  default_scope -> { order(updated_at: :desc) }
end
