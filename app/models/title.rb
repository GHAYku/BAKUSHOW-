class Title < ApplicationRecord
 belongs_to :end_user
 belongs_to :genre
 has_many :jokes, dependent: :destroy
end
