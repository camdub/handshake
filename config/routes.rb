Rails.application.routes.draw do
  root 'home_page#show'

  mount API::Base => '/api'
end
