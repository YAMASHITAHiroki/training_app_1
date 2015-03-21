# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

taro = User.create(email: "taro@example.com", nickname: "taro", password: "password")

10.times do |idx|
  taro.microposts.create(content: "#{idx} tweeee")
end

sample_user_names = ["tomoya", "naoki", "mamiko", "sachiko", "bill"]
sample_user_names.each do |user_name|
  user = User.create(email: "#{user_name}@example.com", nickname: "#{user_name}", password: "password")

  5.times do |idx|
    user.microposts.create(content: "#{user_name} #{idx} tweeee")
  end
end
