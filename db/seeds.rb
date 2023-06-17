require 'faker'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

FriendRequest.destroy_all
User.destroy_all
me = User.create(first_name: "Chris", last_name: "Robinson", email: "christanr00@gmail.com", password: "password", gender: "male")
test = User.create(first_name: "Test", last_name: "Doe", email: "example@example.com", password: "password", gender: "male")
me.avatar.attach(io: File.open("app/assets/images/developer.jpg"), filename: "developer.jpg", content_type: "image/jpeg")
10.times do
  first_name = Faker::Name.first_name
  gender = ["male", "female"].sample
  User.create(first_name: first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email(name: first_name),
              password: Faker::Internet.password(min_length: 6), gender: gender)
end

i = 0
User.all.shuffle.each do |user| 
  if i < 3
    p = user.posts.create(body: Faker::Hacker.say_something_smart)
  elsif i < 6
    p = user.posts.create(body: Faker::TvShows::HeyArnold.quote)
  else
    p = user.posts.create(body: Faker::TvShows::Spongebob.quote)
  end
  user.likes.create(post: p)
  i += 1
end

first_post = Post.find(Post.pluck(:id).sample)
first_post.photo.attach(io: File.open("app/assets/images/dock.jpg"), filename: "dock.jpg", content_type: "image/jpeg") 
second_post = Post.find(Post.pluck(:id).sample)
until second_post.photo.attached?
  second_post.photo.attach(io: File.open("app/assets/images/nature.jpg"), filename: "nature.jpg", content_type: "image/jpeg") unless second_post.photo.attached?
end

User.all.each do |user|
  request = user.requests.new(received_user: User.find(User.pluck(:id).sample))
  request.save if request.valid?
end

User.all.each do |user|
  friend = User.find(User.pluck(:id).sample)
  until friend != user
    friend = User.find(User.pluck(:id).sample)
  end
  p friend
  request_open = FriendRequest.where(sent_user: user, received_user: friend).exists? || FriendRequest.where(sent_user: friend, received_user: user).exists?
  while request_open || friend == user
    friend = User.find(User.pluck(:id).sample)
    request_open = FriendRequest.where(sent_user: user, received_user: friend).exists? || FriendRequest.where(sent_user: friend, received_user: user).exists?
  end
  p request_open
  user.friendships.create(friend: friend)
  friend.friendships.create(friend: user)
end