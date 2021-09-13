class Comment < ApplicationRecord
  belongs_to :end_user
  belongs_to :post
  validates :comment, presence: true, length: { maximum: 120 }
end
