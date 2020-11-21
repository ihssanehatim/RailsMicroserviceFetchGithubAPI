Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace 'api'  do
  namespace 'v1'  do
    # Here I am defining the routes of the REST API I am providing
    # In this Rails microservice app
      get '/languages' , to: 'languages#index'
      get '/languages/:language' , to: 'languages#language'
    end
  end
end
