class SessionsController < ApplicationController
    
    def new
        @user = User.new
    end

    def create 
        pw = Digest::SHA1.hexdigest("a#{params[:user][:password]}z")
        @user = User.find_by(email: params[:user][:email],
                        password: pw)

        if User.login(params[:user])
            session[:user1123]= params[:user][:email]
            #HTTP是沒有狀態的，為了在HTTP認得你，在登錄時會產生成對的session（伺服器）跟cookie（使用者端），雙方核對成功之後，就可以讓你在切換頁面時，可以維持狀態。
            # https://medium.com/@pk60905/rails-session-cookie%E5%92%8Cflash-f6cbb712b876
            redirect_to root_path,notice:'登入成功'
        else
            redirect_to session_path,notice:'登入失敗'
        end
    end

    def destroy
    session[:user1123] = nil
    redirect_to root_path,notice:'登出成功'

    end





end
