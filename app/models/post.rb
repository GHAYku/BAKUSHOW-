class Post < ApplicationRecord
 attachment :image
 belongs_to :end_user
 belongs_to :genre
 has_many :reposts, dependent: :destroy
 has_many :reviews, dependent: :destroy
 has_many :comentes, dependent: :destroy
end
