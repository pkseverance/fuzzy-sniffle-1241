class ChefsController < ApplicationController
    def show
        @chef = Chef.find(params[:id])
    end

    def ingredients_index
        @chef = Chef.find(params[:id])
    end

    def update
        @chef = Chef.find(params[:id])
        @dish = Dish.find(params[:add_dish])
        @chef.dishes << @dish
        redirect_to "/chefs/#{@chef.id}"
    end
end