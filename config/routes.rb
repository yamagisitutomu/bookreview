Rails.application.routes.draw do
  get 'tags/show'
# 顧客用
# URL /customers/sign_in ...
devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

root to: 'public/homes#top'
 get 'homes/about' => "public/homes#about", as: :about

# 管理者側
  namespace :admin do
    get 'homes/top' => 'homes#top'
    resources :customers, only: [:show, :edit, :update, :index] do
      member do
      get 'show_post_history'
      end
    end
    resources :books, only: [:show], param: :isbn do
      resources :posts, only: [:show, :destroy] do
        resources :comments, only: [:destroy]
      end
    end
  end

 # 会員側
  scope module: :public do
    get  '/customers/information/edit' => 'customers#edit'
    patch  '/customers/information' => 'customers#update'
 # 退会確認画面
    get  '/customers/check' => 'customers#check'
 # 論理削除用のルーティング
    patch  '/customers/withdraw' => 'customers#withdraw'
    resources :customers, only: [:show, :edit, :update, :index]
    resources :books, only: [:show, :index], param: :isbn do
      resources :posts, only: [:show, :edit, :create, :update, :destroy] do
        resources :comments, only: [:create, :destroy]
      end
    end
  end
  # 本の検索
  get "search" => "searches#search"
  # 投稿の検索で使用する
  get "/post_search" => "post_searches#search"
  resources :tags, only: [:show]
  end

