# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

crockpot = Category.create(name: 'crockpot')
potato_soup = Recipe.create(
  name: 'Potato Soup',
  author: 'Austin Covrig'
)
potato_soup.ingredients << [
  Ingredient.create(
    qty: 1,
    unit: 'pkg',
    item: 'Ore Ida Potatoes Obrien'
  ),
  Ingredient.create(
    qty: 1,
    unit: 'cup',
    item: 'water'
  ),
  Ingredient.create(
    qty: 1,
    unit: 'can',
    item: 'cream of celery soup'
  ),
  Ingredient.create(
    qty: 4,
    unit: 'oz',
    item: 'cream cheese'
  ),
  Ingredient.create(
    qty: 0.5,
    unit: 'cup',
    item: 'milk'
  )
]
potato_soup.directions << [
  Direction.create(
    step: 1,
    action: 'Put the potatoes, water, and soup in the crockpot on medium for 6 hours.'
  ),
  Direction.create(
    step: 2,
    action: 'Stir in the cheese and milk before serving.'
  )
]
potato_soup.utensils << [
  Utensil.create(name: 'Crockpot', qty: 1),
  Utensil.create(name: 'Stirring Spoon', qty: 1)
]

spice_cake = Recipe.create(
  name: 'Apple Spice Cake',
  author: 'Austin Covrig'
)
spice_cake.ingredients << [
  Ingredient.create(
    qty: 2,
    unit: 'cans',
    item: 'apple pie filling',
    note: '20oz cans'
  ),
  Ingredient.create(
    qty: 1,
    unit: 'box',
    item: 'spice cake mix'
  ),
  Ingredient.create(
    qty: 8,
    unit: 'oz',
    item: 'butter'
  )
]
spice_cake.directions << [
  Direction.create(
    step: 1,
    action: 'Pour apples into bottom of crockpot.'
  ),
  Direction.create(
    step: 2,
    action: 'Spread cake mix over apples.'
  ),
  Direction.create(
    step: 3,
    action: 'Place butter ontop of cake mix.'
  ),
  Direction.create(
    step: 4,
    action: '3 hours on high.'
  )
]
spice_cake.utensils << [
  Utensil.create(name: 'Crockpot', qty: 1)
]

crockpot.recipes << [potato_soup, spice_cake]

# cats = %w(desert easy crockpot healthy)
# cats.each do |cat|
#   print "\rCategory #{cat} -> Recipe"
#   cat = Category.create(
#     name: cat
#   )
#   (1..10).each do |ri|
#     print "\rCategory #{cat.name} -> Recipe #{ri}"
#     r = Recipe.create(
#       name: Faker::Food.dish,
#       author: Faker::Name.name,
#       serving_size: Faker::Number.between(1,10),
#       serving_suggestion: Faker::Food.measurement,
#       rating: Faker::Number.decimal(1, 5)
#     )
#     (1..10).each do |ui|
#       print "\rCategory #{cat.name} -> Recipe #{ri} Utensil #{ui}                                      "
#       utensil = Utensil.create(
#         recipe: r,
#         name: Faker::Food.spice,
#         qty: Faker::Number.between(1,5)
#       )
#     end
#     (1..10).each do |di|
#       print "\rCategory #{cat.name} -> Recipe #{ri} Utensil Direction #{di}                             "
#       direction = Direction.create(
#         step: di,
#         action: Faker::Hacker.verb
#       )
#       r.directions << direction
#     end
#     (1..10).each do |ii|
#       print "\rCategory #{cat.name} -> Recipe #{ri} Utensil Direction Ingredient #{ii}                   "
#       ingredient = Ingredient.create(
#         qty: Faker::Number.between(1, 10),
#         unit: Faker::Measurement.height("none"),
#         item: Faker::Food.spice,
#         note: Faker::Lorem.sentence
#       )
#       r.ingredients << ingredient
#     end
#     (1..10).each do |ni|
#       print "\rCategory #{cat.name} -> Recipe #{ri} Utensil Direction Ingredient Note #{ni}               "
#       note = Note.create(
#         note: Faker::Lorem.paragraph
#       )
#       r.notes << note
#     end
#     (1..10).each do |pi|
#       print "\rCategory #{cat.name} -> Recipe #{ri} Utensil Direction Ingredient Note Picture #{pi}       "
#       picture = Picture.create(
#         fname: Faker::File.file_name,
#         sum: Faker::Internet.password(32, 32),
#         width: Faker::Number.between(800, 4000),
#         height: Faker::Number.between(800, 4000),
#         size: Faker::Number.between(800, 10000)
#       )
#       r.pictures << picture
#     end
#     begin
#       cat.recipes << r
#     rescue
#       next
#     end
#   end
#   puts ''
# end