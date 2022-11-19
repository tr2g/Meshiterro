Rails.application.routes.draw do
  root to: 'homes#top'
  devise_for :users

  resources :post_images, only: [:new, :create, :index, :show, :destroy] do
    resource :favorites, pnly: [:create, :destroy]
    #↑単数形にすると/:idが含まてなくなる。いいね機能は「一人のユーザーは一つの投稿に対して一回しかいいねできない仕様」だから。
    #resourceは「それ自身のidがわからなくても、関連する他のモデルのidから特定できる」場合に使うことが多い
    resources :post_comments, only: [:create, :destroy]
  end
  resources :users, only: [:show, :edit, :update]

  get 'homes/about' => 'homes#about', as: 'about'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
