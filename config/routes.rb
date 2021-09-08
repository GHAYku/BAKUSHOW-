Rails.application.routes.draw do

  devise_for :end_users, controllers: { omniauth_callbacks: 'end_users/omniauth_callbacks' }

 scope module: :public do
  root 'homes#top'
 end

 namespace :public do
   resources :titles, only:[:index, :show, :new, :create] do
    collection do
     get 'confirmation'
    end
   end


     get 'searchs/search'
     get 'searchs/post_search'
     get 'searchs/title_search'

   resources :jokes,expect:[:new]
   resources :posts do
    resource :reposts, only: [:create, :destroy]
    resources :comments, only:[:create,:destroy,:update]
    resources :reviews, only:[:create,:update,:edit]
   end

   resources :end_users, only:[:edit, :update, :show] do
    collection do
     get 'favorite'
     patch 'withdrawal'
    end
    resource :relationships, only: [:create, :destroy]
     get 'followings' => 'relationships#followings', as: 'followings'
     get 'followers' => 'relationships#followers', as: 'followers'
   end


    get 'homes/bakushow'
    get 'homes/home'
    get 'homes/new'
    get 'homes/popular'
    get 'homes/about'
  end
end
