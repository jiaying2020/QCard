class ApplicationController < ActionController::Base
  include SessionsHelper

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    # 如果得到錯誤訊息ActiveRecord::RecordNotFound，就用with後面的方法解決，這裡用hello來命名（可替換）
    #  private

    # def hello
      # render file: 'public/404.html', layout:false,
      # status:not_found
      # render 404畫面，不要有layout，修改狀態為404（not_found)
      #有一個檔案會專門顯示不存在的404頁面(正常)
    # end

    private
    def session_required
      redirect_to sign_in_users_path, notice: '請先登入會員' unless user_signed_in?
    end
  
    def record_not_found
      render file: 'public/404.html',
             layout: false,
             status: :not_found
    end
    

end


