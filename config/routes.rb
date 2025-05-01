Rails.application.routes.draw do
  
  root 'home#index'

  get '/login', to: 'auth#new', as: :login
  post '/login', to: 'auth#create' 
  delete '/logout', to: 'auth#destroy'

  get '/account', to: 'account#new'
  post '/account', to: 'account#create' 

  get '/announcement/:id', to: 'announcement#display',  as: :announcement

  get '/annoucements/search', to: 'announcement#search'

  get '/myAnnouncements', to:'announcement#displayMyAnnouncements', as: :myAnnouncements

  get 'edit/:id', to: 'announcement#edit'
  patch '/edit/:id', to: 'announcement#postEdit', as: 'edit_announcement_post'
 
  get '/add/1', to: 'announcement#form1', as: :form1
  post '/add/1', to: 'announcement#postForm1'

  get '/add/2', to: 'announcement#form2', as: :form2
  post '/add/2', to: 'announcement#postForm2'

  get '/add/3', to: 'announcement#form3', as: :form3
  post '/add/3', to: 'announcement#postForm3'

  delete '/deleteAnnouncement/:id', to: 'announcement#delete', as: :delete_announcement

  get 'not_found', to:'announcement#not_found', as: :not_found

  match "*unmatched", to: "announcement#not_found", via: :all, constraints: lambda { |req|
  !req.path.starts_with?("/rails/active_storage")
}

end