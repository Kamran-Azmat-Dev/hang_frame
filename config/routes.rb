require 'sidekiq/web'

Rails.application.routes.draw do
  put 'spree/checkout/update_order_price_custom', to: 'spree/checkout#update_order_price_custom'
  put 'spree/checkout/remove_pickup_price', to: 'spree/checkout#remove_pickup_price'
  namespace :api do
    post 'hang_photos/upload', to: 'hang_photos#upload_photo', as: :upload_hang_photo
    post 'hang_photos/crop_photo', to: 'hang_photos#crop_photo', as: :crop_hang_photo
    post 'hang_photos/edit_photo_crop', to: 'hang_photos#edit_photo_crop', as: :edit_hang_photo_crop
    get 'hang_photos/photo', to: 'hang_photos#photo', as: :show_hang_photo
    get 'hang_photos/available_options', to: 'hang_photos#available_options', as: :show_hang_photo_available_options
    post 'gift_wrappes/update_name_and_message', to: 'gift_wrappes#update_name_and_message', as: :update_name_and_message
    post 'gift_wrappes/add_original_art_packaging', to: 'gift_wrappes#add_original_art_packaging', as: :add_original_art_packaging

    resources :custom_frames, only: [:show] do
      collection do
        get :chevrons
      end
    end

    resources :standard_frames, only: [:show] do
      collection do
        get :chevrons
      end
    end

    namespace :backend do
      get 'search/mount_types', to: 'search#mount_types', as: :search_mount_types
      get 'search/mount_options', to: 'search#mount_options', as: :search_mount_options
      get 'search/additionals', to: 'search#additionals', as: :search_additionals
    end
  end

  mount Spree::Core::Engine, at: '/'

  Spree::Core::Engine.add_routes do
    resource :upload, only: [] do
      get :digital
      get :original_art
    end

    resources :frames, only: [:index]

    resource :newsletter, only: [:create]

    namespace :admin do
      authenticate :spree_user, lambda { |u| u.has_spree_role?('admin') } do
        mount Sidekiq::Web => '/sidekiq'
      end

      resources :custom_frame_moulding_types
      resources :custom_frame_print_sizes do
        resources :custom_frame_moulding_type_prices
      end
      resources :custom_frame_mount_types
      resources :custom_frame_mount_options
      resources :custom_frame_additionals

      resources :custom_frame_foil_blocking_colors do
        collection do
          post :update_positions
        end
      end

      resources :original_art_types

      resources :products do
        resources :frame_preview_images
      end

      resources :custom_frame_mount_colors do
        collection do
          post :update_positions
        end

        resources :custom_frame_mount_preview_images
      end

      resources :custom_mount_preferences

      resources :worksheets, only: [:show] do
        member do
          get :preview_frame
        end
      end
    end
  end
end
