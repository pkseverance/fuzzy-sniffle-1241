require 'rails_helper'

RSpec.describe 'Chef show page' do
    before(:each) do
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
    end

    describe "When I visit a chef's show page" do
        it 'has the name of the chef' do
            visit "/chefs/#{@chef_1.id}"

            expect(page).to have_content(@chef_1.name)
        end

        it 'has a list of dishes that belong to that chef' do
            visit "/chefs/#{@chef_1.id}"

            expect(page).to have_content(@chef_1.dishes.first.name)
            expect(page).to have_content(@chef_1.dishes.last.name)
        end

        it 'has a form to add an existing dish to that chef' do
            visit "/chefs/#{@chef_1.id}"

            expect(page).to have_field('Add Dish')
        end

        describe 'When I fill in the form and click submit' do
            it 'should list the new dish' do
                visit "/chefs/#{@chef_1.id}"

                fill_in('Add Dish', with: @dish_3.id)
                click_button('Submit')

                expect(current_path).to eq("/chefs/#{@chef_1.id}")

                expect(page).to have_content(@dish_3.name)
            end
        end

        it 'has a link to view a list of all ingredients used by this chef' do
            visit "/chefs/#{@chef_1.id}"

            expect(page).to have_link('Ingredients')

            click_link ('Ingredients')

            expect(current_path).to eq("/chefs/#{@chef_1.id}/ingredients")
        end
    end

    describe 'Chef ingredient index' do
        it 'has a list of all ingredients used by this chef' do
            visit "/chefs/#{@chef_1.id}/ingredients"

            expect(page).to have_content(@chef_1.ingredients.first.name)
            expect(page).to have_content(@chef_1.ingredients.last.name)
        end
    end
end