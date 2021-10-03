class Post < ApplicationRecord
  attachment :image
  belongs_to :end_user
  belongs_to :genre
  belongs_to :title, optional: true
  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :body, presence: true, length: { maximum: 60 }
 def self.search(body)
  where(["body like?", "%#{body}%"])
 end
end