class Comente < ApplicationRecord
 belongs_to :end_user
 belongs_to :joke
 belongs_to :post
end
