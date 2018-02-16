# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

cats = %w(desert easy crockpot healthy)
cats.each do |cat|
  print "\rCategory #{cat} -> Recipe"
  cat = Category.create(
    name: cat
  )
  (1..10).each do |ri|
    print "\rCategory #{cat.name} -> Recipe #{ri}"
    r = Recipe.create(
      name: Faker::Food.dish,
      author: Faker::Name.name,
      serving_size: Faker::Number.between(1,10),
      serving_suggestion: Faker::Food.measurement,
      rating: Faker::Number.decimal(1, 5)
    )
    (1..10).each do |ui|
      print "\rCategory #{cat.name} -> Recipe #{ri} Utensil #{ui}                                      "
      utensil = Utensil.create(
        name: Faker::Food.spice,
        qty: Faker::Number.between(1,5)
      )
      r.utensils << utensil
    end
    (1..10).each do |di|
      print "\rCategory #{cat.name} -> Recipe #{ri} Utensil Direction #{di}                             "
      direction = Direction.create(
        step: di,
        action: Faker::Hacker.verb
      )
      r.directions << direction
    end
    (1..10).each do |ii|
      print "\rCategory #{cat.name} -> Recipe #{ri} Utensil Direction Ingredient #{ii}                   "
      ingredient = Ingredient.create(
        qty: Faker::Number.between(1, 10),
        unit: Faker::Measurement.height("none"),
        item: %w(can bag box).sample,
        note: Faker::Lorem.sentence
      )
      r.ingredients << ingredient
    end
    (1..10).each do |ni|
      print "\rCategory #{cat.name} -> Recipe #{ri} Utensil Direction Ingredient Note #{ni}               "
      note = Note.create(
        note: Faker::Lorem.paragraph
      )
      r.notes << note
    end
    (1..10).each do |pi|
      print "\rCategory #{cat.name} -> Recipe #{ri} Utensil Direction Ingredient Note Picture #{pi}       "
      picture = Picture.create(
        fname: Faker::File.file_name,
        sum: Faker::Internet.password(32, 32),
        width: Faker::Number.between(800, 4000),
        height: Faker::Number.between(800, 4000),
        size: Faker::Number.between(800, 10000)
      )
      r.pictures << picture
    end
    cat.recipes << r
  end
  puts ''
end