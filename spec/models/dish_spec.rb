require 'rails_helper'

RSpec.describe Dish, type: :model do
  describe "validations" do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:description)}
  end

  describe "relationships" do
    it {should belong_to(:chef)}
    it {should have_many(:dish_ingredients)}
    it {should have_many(:ingredients).through(:dish_ingredients)}
  end

  describe '#total_calories' do
    it 'returns the total calories of a dish' do
      @chef_1 = Chef.create!(name: 'Chef Gusteau')
      @dish_1 = @chef_1.dishes.create!(name: 'Ratatouille', description: 'A french dish of layered stewed vegetables')
      @ingredients_1 = [Ingredient.create!(name: 'Tomato', calories: 5), Ingredient.create!(name: 'Squash', calories: 8), Ingredient.create!(name: 'Onion', calories: 4)]

      @ingredients_1.each do |ingredient|
        @dish_1.ingredients << ingredient
      end

      expect(@dish_1.total_calories).to eq(17)
    end
  end
end