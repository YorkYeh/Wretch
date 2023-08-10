Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root 'pages#home'
  # 首頁的寫法
  # get '/' ,to:'pages#home'
  
  # get '/articles' ,to:'articles#index'
  # get '/articles/new',to:'articles#new'
  # post '/articles', to:'articles#create'
  # #單一頁面，把後方的內容比對成ID
  # #否則'/articles/new' 的new 會被比對成id
  # get '/articles/:id', to:'articles#show', as: 'article'
  # get 'articles/:id/edit',to:'articles#edit',as: 'article_edit'
  # patch 'articles/:id',to:'articles#update'
  # delete 'articles/:id',to:'articles#destroy'

  resources :articles do 
    member do 
      patch :unlock
    end
    resources :comments,only: [:create, :destroy], shallow: true
  end

  resources :albums do
    member do
      patch :sort
    end
  end

  resource :users , expect: [:show,:destroy] do 
    collection do
      get :login
      post :logining
      delete :logout
    end
  end  

  resources :payments,only:[:show]


  resources :orders,only:[:index, :show, :create] do 
    member do
      get :pay
      patch :please_pay
    end
  end
  
  # get "/orders/:num/pay", to: 'orders#pay'

  namespace :api do
    namespace :v1 do
      resources :articles, only: [] do
        member do
          patch :like
        end
      end
    end
  end



  get '/about' ,to:'pages#about'

  get '/pricing',to:'pages#pricing'
  
end
