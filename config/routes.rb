Rails.application.routes.draw do
  get 'test_view/test_view'
  root 'search#find_comments'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
