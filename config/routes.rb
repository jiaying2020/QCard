Rails.application.routes.draw do
  root 'boards#index'
 
  resource :users, controller: 'registrations', only: [:create, :edit, :update] do
    get '/sign_up', action: 'new'
  end


  resource :users, controller: 'sessions',only: [] do
    get '/sign_in', action:'new'
    post '/sign_in', action:'create'
    delete '/sign_out',action:'destroy'
    
  end

  resources :boards do
      member do
        patch :hide
        patch :open
        patch :lock
      end
      resources :posts, shallow: true
  end

  resources :posts, only:[] do
    resources :comments, shallow: true, only: [:create, :destroy]
    member do
      post :favorite  # POST /posts/:id/favorite
    end
  end
end
 
# 範例寫法
  # /profiles/123
  # resources :accounts do
    # resources :profiles, shallow: true(意思等同下一行)
    # resources :profiles, only: [:index, :new, :create]
    # /accounts/2/profiles  列表
    # /accounts/2/profiles/new  新增
    # /accounts/2/profiles/create  新增
  # end

  # []在這裡代表全要
  # resources :profiles, only: [:show, :edit, :update, :destroy]
  # /profiles/123  show
  # /profiles/123/edit

  #shallow表示有巢狀結構，要看得懂


  #只開create,edit,update
  # 以下重複整理成上面
   # get '/users/sign_up', to: 'registrations#new',as:'registration'
  # post '/users', to:'registrations#create'
  # get "/users/edit", to: "registrations#edit", as: 'edit_registration'
  # put "/users/edit", to: "registrations#update", as: 'update_registration'

 

  #單數resource＝給使用者用，沒有id
  #負數resources＝給系統者用，有id
  #get讀取
  #post新增
  #在這裡新增八條路徑以外的
  # 這裡是把users給registrations的controlloer託管
  # 路徑可以跟controller不同名

  #會員系統：devise是用「新增session」的方式設計，了解後就改得動
  # devise把註冊跟使用者登錄切開，各自視為獨立行為，把行為模組化
  # session通常沒有edit，像單次取票，要的會就重抽
 

 # get '/boards/new', to: 'boards#new'
  # get '/login', to: 'login#index'
  # get '/login', to: 'login#new'
  # get '/board/login', to: 'board#login'
  # get '/users/login', to: 'users#login'
  # get '/members/login', to: 'members#login'


  #resources :boards <---如果要生新增修改刪除的八條路徑
  #p.158
  #resources :boards, only [:insex, ]<--限制功能
  # get '/boards', to: 'boards#index' #
  # get '/about', to: 'pages#about' #關於我們
  # get '/info', to: 'pages#info' #企業介紹
  # get '/', to: 'pages#home' #首頁

