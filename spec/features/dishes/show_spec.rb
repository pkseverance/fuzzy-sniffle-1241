require 'rails_helper'

RSpec.describe 'Dishes show page' do
    before(:each) do
        @chef_1 = Chef.create!(name: 'Chef Gusteau')
        @chef_2 = Chef.create!(name: 'Chef Skinner')

        @ingredients_1 = [Ingredient.create!(name: 'Tomato', calories: 5), Ingredient.create!(name: 'Squash', calories: 8), Ingredient.create!(name: 'Onion', calories: 4)]
        @ingredients_2 = [Ingredient.create!(name: 'Potato', calories: 30), Ingredient.create!(name: 'Beans', calories: 60), Ingredient.create!(name: 'Cheese', calories: 80)]

        @dish_1 = @chef_1.dishes.create!(name: 'Ratatouille', description: 'A french dish of layered stewed vegetables')
        @dish_2 = @chef_2.dishes.create!(name: 'Microwave burrito', description: 'A sub-par potato, beans, and cheese based microwaveable burrito')

        @ingredients_1.each do |ingredient|
            @dish_1.ingredients << ingredient
        end

        @ingredients_2.each do |ingredient|
            @dish_2.ingredients << ingredient
        end
    end


    describe "When I visit a dish's show page" do
        it "has the dish's name and description" do
            visit "/dishes/#{@dish_1.id}"

            expect(page).to have_content(@dish_1.name)
            expect(page).to have_content(@dish_1.description)

            visit "/dishes/#{@dish_2.id}"

            expect(page).to have_content(@dish_2.name)
            expect(page).to have_content(@dish_2.description)
        end

        it 'has a list of ingredients for that dish' do
            visit "/dishes/#{@dish_1.id}"

            expect(page).to have_content(@dish_1.ingredients.first.name)
            expect(page).to have_content(@dish_1.ingredients.last.name)

            visit "/dishes/#{@dish_2.id}"

            expect(page).to have_content(@dish_2.ingredients.first.name)
            expect(page).to have_content(@dish_2.ingredients.last.name)
        end

        it 'has a total calorie count for that dish' do
            visit "/dishes/#{@dish_1.id}"

            expect(page).to have_content(@dish_1.total_calories)

            visit "/dishes/#{@dish_2.id}"

            expect(page).to have_content(@dish_2.total_calories)
        end

        it "has the chef's name" do
            visit "/dishes/#{@dish_1.id}"

            expect(page).to have_content(@dish_1.chef.name)

            visit "/dishes/#{@dish_2.id}"

            expect(page).to have_content(@dish_2.chef.name)
        end
    end
end