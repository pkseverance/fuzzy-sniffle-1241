# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
    
@chef_1 = Chef.create!(name: 'Chef Gusteau')
@chef_2 = Chef.create!(name: 'Chef Skinner')

@ingredients_1 = [Ingredient.create!(name: 'Tomato', calories: 5), Ingredient.create!(name: 'Squash', calories: 8), Ingredient.create!(name: 'Onion', calories: 4)]
@ingredients_2 = [Ingredient.create!(name: 'Potato', calories: 30), Ingredient.create!(name: 'Beans', calories: 60), Ingredient.create!(name: 'Cheese', calories: 80)]

@dish_1 = @chef_1.dishes.create!(name: 'Ratatouille', description: 'A french dish of layered stewed vegetables')
@dish_2 = @chef_2.dishes.create!(name: 'Microwave burrito', description: 'A sub-par potato, beans, and cheese based microwaveable burrito')
@dish_3 = @chef_2.dishes.create!(name: 'Tomato Soup', description: 'A creamy warm soup made with fresh tomatoes')

@ingredients_1.each do |ingredient|
    @dish_1.ingredients << ingredient
end

@ingredients_2.each do |ingredient|
    @dish_2.ingredients << ingredient
end