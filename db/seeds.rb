# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# create screens
screens = Screen.create([
  {room_number: 1, capacity: 25},
  {room_number: 2, capacity: 125},
  {room_number: 3, capacity: 50},
  {room_number: 4, capacity: 50},
  {room_number: 5, capacity: 75},
  {room_number: 6, capacity: 75},
  {room_number: 7, capacity: 25},
  {room_number: 8, capacity: 50},
  {room_number: 9, capacity: 50},
  {room_number: 10, capacity: 100}
  ])

# create movies
movies = Movie.create([
  {title: "Crazy Rich Asians"},
  {title: "The Meg"},
  {title: "The Happytime Murders"},
  {title: "Mile 22"},
  {title: "Christopher Robin"},
  {title: "Alpha"},
  {title: "Mission: Impossible - Fallout"},
  {title: "Operation Finale"},
  {title: "Incredibles 2"},
  {title: "Mamma Mia! Here We Go Again"}
])


# create showtimes
14.times do
  Showtime.create(
  screen_id: Random.new.rand(9),
  movie_id: Random.new.rand(9),
  time: "#{Faker::Time.forward(40, :morning)}",
  tickets_sold: 0,
  price: 6.25
)
end

# create showtimes
14.times do
  Showtime.create(
  screen_id: Random.new.rand(9),
  movie_id: Random.new.rand(9),
  time: "#{Faker::Time.forward(40, :evening)}",
  tickets_sold: 0,
  price: 10.25
)
end


# create orders
20.times do
  Order.create(
  name: "#{Faker::Name.name}",
  email: "#{Faker::Internet.free_email}",
  credit_card_number: "#{Faker::Stripe.valid_card}",
  expiration_date: "#{Faker::Date.forward(50)}",
  quantity: Random.new.rand(3),
  showtime_id: Random.new.rand(27)
)
end
