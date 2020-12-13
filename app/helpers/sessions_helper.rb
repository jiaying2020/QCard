module SessionsHelper
    def current_user
        if session[:user1123].present? #email
        @_user1123 ||= User.find_by(email: session[:user1123])
        else 
            nil
        end
    end

    def user_signed_in?
        if current_user
          return true
        else
          return false
        end
      end


end
