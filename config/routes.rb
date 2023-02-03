Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: "users/registrations",
                                   sessions: "users/sessions"}

  root "static_pages#index"

  get "faq", to: "static_pages#faq", as: "static_pages/faq"
  get 'reports', to: 'reports#index', as: 'reports/index'
  get 'reports/report_by_category', to: 'reports#report_by_category', as: 'reports/report_by_category'
  get 'reports/report_by_dates', to: 'reports#report_by_dates', as: 'reports/report_by_dates'

  resources :categories, except: :show
  resources :operations, except: :index
end
