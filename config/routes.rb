MobileSite::Application.routes.draw do

  devise_for :clients

  resources :products do
    member do
      get :product_details
    end
  end

  resources :users do
    member do
      get :confirmation
    end
    collection do
      get :user_details
    end
  end

  authenticated :client do
    root :to => "home#index"
  end

  unauthenticated :client do
    devise_scope :client do 
      get "/" => "devise/sessions#new"
    end
  end

  match "/product/1800response/:one_eight_hundred_number" => "products#get_xml_product_details"
end
