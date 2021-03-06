class Title < ApplicationRecord
  attachment :image
  belongs_to :end_user
  belongs_to :genre
  has_many :posts, dependent: :destroy

  validates :body, presence: true, length: { maximum: 120 }
 def self.tite_search(body)
  where(["body like?", "%#{body}%"])
 end
end
