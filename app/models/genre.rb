class Genre < ApplicationRecord
 has_many :titles
 has_many :posts
end
