Supporty::Application.routes.draw do
  resources :support

  root :to => "support#index"
end
