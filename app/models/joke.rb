class Joke < ApplicationRecord
 belongs_to :end_user
 belongs_to :genre
 belongs_to :tittle
 has_many :reposts, dependent: :destroy
 has_many :reviews, dependent: :destroy
 has_many :comentes, dependent: :destroy
end
