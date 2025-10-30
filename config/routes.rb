Rails.application.routes.draw do
  get 'maintenance_mode_settings', to: 'maintenance_mode_settings#index', as: 'maintenance_mode_settings'
  post 'maintenance_mode_settings', to: 'maintenance_mode_settings#index'
end