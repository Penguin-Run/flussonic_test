Rails.application.routes.draw do
  get '/get-version', to: 'versions#index'
end
