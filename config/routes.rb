Refinery::Core::Engine.routes.draw do
  # Frontend routes
  namespace :messages do
    resources :messages, :path => '', :only => [:new, :create] do
      collection do
        get :thank_you
      end
    end
  end

  # Admin routes
  namespace :messages, :path => '' do
    namespace :admin, :path => "#{Refinery::Core.backend_route}/messages" do
      resources :messages, :path => '' 
      resources :settings, :only => [:edit, :update]
    end
  end
end

