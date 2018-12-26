Rails.application.routes.draw do
  devise_for :users
  get "users/top"
  get "users/about"
  root to: "users#top"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :books
  # 今回必要な作業は①新規投稿new(付随してcreate),②更新edit(付随してupdate),③詳細表示show,④一覧表示index,⑤削除機能destroy

  resources :users, only: [:show, :edit, :update, :index]
  # 今回必要な作業は①詳細表示show(付随してupdate),②更新edit(付随してupdate)
  # 新規登録に関しては"devise"で実装済みのため不要

end
