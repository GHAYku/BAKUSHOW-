Rails.application.routes.draw do
<<<<<<< HEAD
  devise_for :end_users, controllers: { omniauth_callbacks: 'end_users/omniauth_callbacks' }

=======
  devise_for :end_users,
             controllers: {omniauth_callbacks: 'end_users/omniauth_callbacks',registrations: 'endusers/registrations'
}
>>>>>>> ef8f51c3eef3fed6684adb36e566fe9b9bc6f983
  namespace :public do
    get 'titles/index'
    get 'titles/new'
    get 'titles/show'
  end
  namespace :public do
    get 'searchs/new'
    get 'searchs/search'
  end
  namespace :public do
    get 'jokes/index'
    get 'jokes/edit'
    get 'jokes/new'
    get 'jokes/show'
  end
  namespace :public do
    get 'posts/index'
    get 'posts/edit'
    get 'posts/new'
    get 'posts/show'
  end
  namespace :public do
    get 'users/show'
    get 'users/edit'
    get 'users/index'
    get 'users/favorite'
  end
  namespace :public do
    get 'homes/top'
    get 'homes/home'
    get 'homes/new'
    get 'homes/popular'
    get 'homes/about'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
