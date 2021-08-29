Rails.application.routes.draw do

  devise_for :end_users, controllers: { omniauth_callbacks: 'end_users/omniauth_callbacks' }

  namespace :public do

   resources :titles, only:[:index, :show, :new, :create] do
    collection do
     get 'confirmation'
    end
   end

   resource :searchs, only:[:new] do
    collection do
     get 'search'
    end
   end

   resources :jokes,expect:[:new]
   resources :posts

   resources :end_users, only:[:edit, :update, :show] do
    collection do
     get 'favorite'
    end
    resource :relationships, only: [:create, :destroy]
     get 'followings' => 'relationships#followings', as: 'followings'
     get 'followers' => 'relationships#followers', as: 'followers'
   end


    root 'homes#top'
    get 'homes/home'
    get 'homes/new'
    get 'homes/popular'
    get 'homes/about'
  end
end
