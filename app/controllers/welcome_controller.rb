class WelcomeController < ApplicationController
  def index
    @file = File.read("#{Rails.root}/README.md")
  end

  # Add /no_food_meal endpoint. It should return a list of meals that don't have any food.
  def no_food_meal
    meal_ids = MealFood.pluck(:meal_id).uniq
    @no_food_meal_names = Meal.where.not(id: meal_ids).pluck(:name)
    render json: @no_food_meal_names
  end

  # Add /max_foods endpoint. It should return a maximum number of food across all the meals.
  def max_foods
    @max_foods = Food.joins(:meal_foods).group(:name).count
    render json: @max_foods
  end

  # Add /other_food endpoint. It should return a list of every food as Food Head;
  # with each Food Head, list the pairing food from all the meal combination.
  def other_food
    food_head = params[:food]
    meal_ids_includ_food_head = MealFood.joins(:food).where('foods.name = ?', food_head).pluck(:meal_id)
    food_names = []
    meal_ids_includ_food_head.each do |meal_id|
      food_ids = MealFood.where(meal_id: meal_id).pluck(:food_id)
      names = Food.where(id: food_ids).where.not(name: food_head).pluck(:name)
      food_names << names
    end
    render json: {
      'Food Head': food_head,
      'other_food': food_names.flatten.uniq
    }
  end
end
