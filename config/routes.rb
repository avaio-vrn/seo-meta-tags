# -*- encoding : utf-8 -*-
Seo::Engine.routes.draw do
  namespace :seo do
    resources :meta_tags, except: [:index, :create]
    get 'meta_tags/(:cnt)/(:ac)/(:id_obj)', to: 'meta_tags#index', as: :meta_tags
    post 'meta_tags/(:cnt)/(:ac)/(:id_obj)', to: 'meta_tags#create'
  end
end
