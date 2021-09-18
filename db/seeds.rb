# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
5.times do |n|
  end_user =EndUser.new(:email => "test#{n + 1}@test.com",:name => "テスト太郎#{n + 1}",:encrypted_password => "dmmdmm")
  end_user.save
end

admin_user = Admin.create(:email => "test@test.com",:encrypted_password => "dmmdmm")
admin_user.save