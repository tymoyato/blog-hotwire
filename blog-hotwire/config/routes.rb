# frozen_string_literal: true

Rails.application.routes.draw do
  post '/change_locale', to: 'application#change_locale'
  root to: redirect("/#{I18n.locale}"), as: :redirected_root

  scope "/:locale" do
    devise_for :users
    # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

    # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
    # Can be used by load balancers and uptime monitors to verify that the app is live.
    get 'up' => 'rails/health#show', as: :rails_health_check
    root "pages#home"
  end
  get '*path', to: redirect("/#{I18n.locale}")
end
