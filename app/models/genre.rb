class Genre < ApplicationRecord
 has_many :titles
 has_many :jokes
 has_many :posts
end
