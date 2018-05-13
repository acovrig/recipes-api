# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

print 'User1 '
u1 = User.find_by(email: 'accovrig@gmail.com')
puts "found existing #{u1.id}" if u1
if u1.nil?
  u1 = User.new
  u1.email = 'accovrig@gmail.com'
  u1.password = 'asdf1234'
  u1.password_confirmation = 'asdf1234'
  u1.name = 'Austin Covrig'
  u1.save!
  puts 'done'
end
print 'User2 '
u2 = User.find_by(email: 'aarcov@gmail.com')
puts "found existing #{u2.id}" if u2
if u2.nil?
  u2 = User.new
  u2.email = 'aarcov@gmail.com'
  u2.password = 'asdf1234'
  u2.password_confirmation = 'asdf1234'
  u2.name = 'Aaron Covrig'
  u2.save!
  puts 'done'
end

print 'Crockpot PotatoSoup '
crockpot = Category.find_or_create_by(name: 'crockpot', created_by: u1)
potato_soup = Recipe.find_or_create_by(
  name: 'Potato Soup',
  author: u1
)
Ingredient.find_or_create_by(
  recipe_id: potato_soup.id,
  qty: 1,
  unit: 'pkg',
  item: 'Ore Ida Potatoes Obrien'
)
Ingredient.find_or_create_by(
  recipe_id: potato_soup.id,
  qty: 1,
  unit: 'cup',
  item: 'water'
)
Ingredient.find_or_create_by(
  recipe_id: potato_soup.id,
  qty: 1,
  unit: 'can',
  item: 'cream of celery soup'
)
Ingredient.find_or_create_by(
  recipe_id: potato_soup.id,
  qty: 4,
  unit: 'oz',
  item: 'cream cheese'
)
Ingredient.find_or_create_by(
  recipe_id: potato_soup.id,
  qty: 0.5,
  unit: 'cup',
  item: 'milk'
)

Direction.find_or_create_by(
  recipe_id: potato_soup.id,
  step: 1,
  action: 'Put the potatoes, water, and soup in the crockpot on medium for 6 hours.'
)
Direction.find_or_create_by(
  recipe_id: potato_soup.id,
  step: 2,
  action: 'Stir in the cheese and milk before serving.'
)

Utensil.find_or_create_by(recipe_id: potato_soup.id, name: 'Crockpot', qty: 1)
Utensil.find_or_create_by(recipe_id: potato_soup.id, name: 'Stirring Spoon', qty: 1)

print 'AppleSpiceCake '
spice_cake = Recipe.find_or_create_by(
  name: 'Apple Spice Cake',
  author: u1
)

Ingredient.find_or_create_by(
  recipe_id: spice_cake.id,
  qty: 2,
  unit: 'cans',
  item: 'apple pie filling',
  note: '20oz cans'
)
Ingredient.find_or_create_by(
  recipe_id: spice_cake.id,
  qty: 1,
  unit: 'box',
  item: 'spice cake mix'
)
Ingredient.find_or_create_by(
  recipe_id: spice_cake.id,
  qty: 8,
  unit: 'oz',
  item: 'butter'
)

Direction.find_or_create_by(
  recipe_id: spice_cake.id,
  step: 1,
  action: 'Pour apples into bottom of crockpot.'
)
Direction.find_or_create_by(
  recipe_id: spice_cake.id,
  step: 2,
  action: 'Spread cake mix over apples.'
)
Direction.find_or_create_by(
  recipe_id: spice_cake.id,
  step: 3,
  action: 'Place butter ontop of cake mix.'
)
Direction.find_or_create_by(
  recipe_id: spice_cake.id,
  step: 4,
  action: '3 hours on high.'
)

Utensil.find_or_create_by(recipe_id: spice_cake.id, name: 'Crockpot', qty: 1)

RecipeCategory.find_or_create_by(recipe_id: potato_soup.id, category_id: crockpot.id)
RecipeCategory.find_or_create_by(recipe_id: spice_cake.id, category_id: crockpot.id)
puts 'done'

cats = %w(desert easy crockpot healthy)
cats.each do |c|
  print "\rCategory #{c} -> Recipe"
  cat = Category.find_or_create_by(name: c, created_by: u1)
  ActiveRecord::Base.transaction do
    (1..50).each do |ri|
      print "\rCategory #{cat.name} -> Recipe #{ri}"
      r = FactoryBot.create(:recipe, author: [u1, u2].sample)
      (1..10).each do |ui|
        print "\rCategory #{cat.name} -> Recipe #{ri} Utensil #{ui}                                      "
        utensil = FactoryBot.create(:utensil, recipe: r)
      end
      (1..10).each do |di|
        print "\rCategory #{cat.name} -> Recipe #{ri} Utensil Direction #{di}                             "
        direction = FactoryBot.create(:direction, recipe: r)
      end
      (1..10).each do |ii|
        print "\rCategory #{cat.name} -> Recipe #{ri} Utensil Direction Ingredient #{ii}                   "
        ingredient = FactoryBot.create(:ingredient, recipe: r)
      end
      (1..10).each do |ni|
        print "\rCategory #{cat.name} -> Recipe #{ri} Utensil Direction Ingredient Note #{ni}               "
        note = FactoryBot.create(:note, recipe: r)
      end
      (1..10).each do |pi|
        print "\rCategory #{cat.name} -> Recipe #{ri} Utensil Direction Ingredient Note Picture #{pi}       "
        picture = FactoryBot.create(:picture, recipe: r)
      end
      begin
        cat.recipes << r
      rescue
        next
      end
    end
    puts ''
  end
end