require 'rails_helper'

RSpec.describe Ingredient do
    describe 'relationships' do
        it {should have_many(:dish_ingredients)}
        it {should have_many(:dishes).through(:dish_ingredients)}
    end
end