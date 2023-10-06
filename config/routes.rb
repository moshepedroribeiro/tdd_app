Rails.application.routes.draw do
  resource :customers, only: [:index]
  root to: 'welcome#index'
end
