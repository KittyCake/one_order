Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'
  get 'no_food_meal', :to => 'welcome#no_food_meal'
  get 'max_foods', :to => 'welcome#max_foods'
  get 'other_food', :to => 'welcome#other_food'
end
