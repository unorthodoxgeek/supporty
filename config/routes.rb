Supporty::Application.routes.draw do
  resources :support do
    collection do
      post :gateway
    end
  end
end
