class Joke < ApplicationRecord
 attachment :image
 belongs_to :end_user
 belongs_to :genre
 belongs_to :title
 has_many :reposts, dependent: :destroy
 has_many :reviews, dependent: :destroy
 has_many :comentes, dependent: :destroy

 validates :body, presence: true
end
