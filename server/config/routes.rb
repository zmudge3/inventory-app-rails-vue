Rails.application.routes.draw do
  scope :api do
    scope :v1 do
      resources :containers do
        resources :items
      end
    end
  end
end
