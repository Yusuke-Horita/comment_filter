Rails.application.routes.draw do
  root 'search#find_comments'
  get 'search/find_reply'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
