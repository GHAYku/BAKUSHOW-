Rails.application.routes.draw do
  devise_for :end_users, controllers: { registrations: 'users/registrations', passwords: 'users/passwords' },
                         controllers: { omniauth_callbacks: 'end_users/omniauth_callbacks' }
  devise_scope :end_user do
    post 'end_users/guest_sign_in', to: 'end_users/sessions#guest_sign_in'
  end

  scope module: :public do
    root 'homes#top'
  end

  namespace :public do
    resources :titles

    get 'searchs/search'
    get 'searchs/post_search'
    get 'searchs/title_search'

    get 'posts/title_posts_index'
    get 'posts/reviews_index'
    get 'posts/title_reviews_index'
    resources :posts do
      resources :comments, only: [:create, :destroy, :update]
      resources :reviews, only: [:create, :update, :edit]
    end

    get 'end_users/posts_index'
    get 'end_users/title_posts_index'
    get 'end_users/post_reviews_index'
    get 'end_users/title_reviews_index'
    get 'end_users/reviews_index'
    get 'end_users/titles'
    get 'relationships/follow_index'
    resources :end_users, only: [:edit, :update, :show] do
      collection do
        patch 'withdraw'
      end
      resource :relationships, only: [:create, :destroy]
      get 'other_user_follow_index' => 'relationships#other_user_follow_index'
    end

    get 'homes/bakushow'
    get 'homes/home'
    get 'homes/new'
    get 'homes/popular'
    get 'homes/about'
    get 'homes/myposts'
    get 'homes/myreviews'
  end

  devise_for :admins, path: 'admin', :controllers => {
    :sessions => 'admins/sessions',
  }
  namespace :admin do
    resources :genres, only: [:index, :edit, :update, :destroy, :create]
    resources :comments, only: [:index, :edit, :update, :destroy]
    resources :posts, only: [:index, :edit, :update, :destroy]
    resources :titles, only: [:index, :edit, :update, :destroy]
    resources :end_users, only: [:index, :edit, :update, :destroy]
  end
end
