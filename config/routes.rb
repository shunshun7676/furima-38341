Rails.application.routes.draw do
  root to : 'furimas#index'
  resources :furimas,only: [:index, :show, :new, :create, :destroy, :edit, :update,] do
end
end