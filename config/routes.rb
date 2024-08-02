Rails.application.routes.draw do
  # Rotas para autenticação e registro
  post 'auth/login', to: 'authentication#login'
  post 'signup', to: 'registrations#create'

  # Rotas para tarefas
  resources :tasks, only: [:index, :show, :create, :update, :destroy]
end

