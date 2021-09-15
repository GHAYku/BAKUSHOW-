class Review < ApplicationRecord
  belongs_to :end_user
  belongs_to :post
  validates :rate, presence: true
end
