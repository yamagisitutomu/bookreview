Rails.application.routes.draw do
  namespace :admin do
    get 'customers/index'
    get 'customers/edit'
    get 'customers/show'
  end
  namespace :public do
    get 'customer/show'
    get 'customer/edit'
  end
  namespace :public do
    get 'homes/top'
  end
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

namespace :admin do
  get 'homes/top' => 'homes#top'
  resources :customers, only: [:index, :show, :edit, :update]
  resources :books, only: [:index,:show,] do
   resources :posts, only: [:index, :show, :edit, :update, :destroy]
   resource :favorites, only: [:destroy]
  end
end

scope module: :public do
 # customers
   get  '/customers/mypage' => 'customers#show'
   get  '/customers/information/edit' => 'customers#edit'
   patch  '/customers/information' => 'customers#update'
 # 退会確認画面
   get  '/customers/check' => 'customers#check'
 # 論理削除用のルーティング
   patch  '/customers/withdraw' => 'customers#withdraw'
   resources :customers, only: [:show, :edit, :update]
   resources :books, only: [:index,:show] do
    resources :posts, only: [:index, :show, :edit, :update, :destroy]
    resource :favorites, only: [:create, :destroy]
   end
end

  get "search" => "searches#search"
  get "tag_searches/search" => "tag_searches#search"


end
