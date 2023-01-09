class Chef < ApplicationRecord
  validates_presence_of :name
  has_many :dishes

  def ingredients
    Ingredient.joins(dish_ingredients: [dish: :chef]).where(chefs: {id: self.id})
  end
end