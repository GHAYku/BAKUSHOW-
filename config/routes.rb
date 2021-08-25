Rails.application.routes.draw do

  devise_for :end_users, controllers: { omniauth_callbacks: 'end_users/omniauth_callbacks' }

  namespace :public do
    resources :relationships, only:[:create, :destroy] do
     collection do
      get 'follows' => 'relationships#follower'
      get 'followers' => 'relationships#followed'
     end
    end

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

   resources :jokes
   resources :posts

   resources :users, only:[:edit, :update, :show] do
    collection do
     get 'favorite'
    end
   end


    root 'homes#top'
    get 'homes/home'
    get 'homes/new'
    get 'homes/popular'
    get 'homes/about'
  end
end
