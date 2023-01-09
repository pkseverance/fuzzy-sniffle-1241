require 'rails_helper'

RSpec.describe Chef, type: :model do
  before(:each) do
    @chef_1 = Chef.create!(name: 'Chef Gusteau')
    @ingredients_1 = [Ingredient.create!(name: 'Tomato', calories: 5), Ingredient.create!(name: 'Squash', calories: 8), Ingredient.create!(name: 'Onion', calories: 4)]
    @dish_1 = @chef_1.dishes.create!(name: 'Ratatouille', description: 'A french dish of layered stewed vegetables')

    @ingredients_1.each do |ingredient|
        @dish_1.ingredients << ingredient
    end
end

  describe "validations" do
    it {should validate_presence_of(:name)}
  end
  describe "relationships" do
    it {should have_many(:dishes)}
  end

  describe '#ingredients' do
    it 'returns a list of ingredients used by the chef' do
      expect(@chef_1.ingredients.first.name).to eq('Tomato')
      expect(@chef_1.ingredients.last.name).to eq('Onion')
    end
  end
end