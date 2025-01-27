Rails.application.routes.draw do
  resources :aulas
  resources :grades_curriculares
  resources :restricoes
  resources :disponibilidade_salas
  resources :curriculo_ementa_disciplinas
  resources :turmas
  resources :matrizes_curriculares_aplicadas
  resources :cursos
  resources :disciplinas
  resources :subareas
  resources :modalidades
  resources :metodologias
  resources :ambientes
  resources :tipos_contratos
  resources :areas
  resources :etapas
  resources :niveis
  resources :instituicoes
  resources :curriculos_ementas
  resources :turnos
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root to: "home#index"
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
