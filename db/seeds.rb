require 'faker'

puts "Dropping data..."
Post.destroy_all
puts "Creating new seed"
5.times do | index |
  puts "creating #{index + 1} Post"
  Post.create(title: Faker::Book.title, content: Faker::Lorem.paragraph)
  puts "#{index + 1} Post created!"
end