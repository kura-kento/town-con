class ApplicationController < ActionController::Base

    before_action :set_current_user

    def set_current_user
      @current_user = User.find_by(id: session[:user_id])
    end

    def acsess
      if session[:user_id] == nil
          flash[:notice] = "ログインして下さい"
          redirect_to("/login")
      end
    end

    def forbid_login_user
      if session[:user_id]
          flash[:notice] = "既にログイン中です"
          redirect_to("/user/top")
      end
    end

    def master_acsess
      if session[:user_id] != 1
       flash[:notice] = "権限がありません"
       redirect_to("/user/top")
      end
    end

    def ensure_correct_user
        if (params[:id]).to_i != @current_user.id
            flash[:notice] = "権限がありません"
            redirect_to("/user/top")
        end
    end

end
