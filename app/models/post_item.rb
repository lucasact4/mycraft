class PostItem < ApplicationRecord
  belongs_to :item
  belongs_to :post
end