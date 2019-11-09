Rails.application.routes.draw do
  root 'buttons#share'
  get 'buttons/share'
  get 'buttons/first'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
