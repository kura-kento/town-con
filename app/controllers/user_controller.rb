class UserController < ApplicationController
   before_action :ensure_correct_user,{only: [:profile_edit_form]}

    def top

    end

    def login_form
    end

    def login
        if @user = User.find_by(email: params[:email],password: params[:password])
            session[:user_id] = @user.id
            flash[:notice] = "ログインに成功しました。"
            redirect_to("/user/top")
        else
            @error_message = "メールアドレスまたはパスワードが間違っています"
            @email = params[:email]
            @password = params[:password]
            render("user/login_form")
        end
    end

    def logout
        session[:user_id] = nil
        redirect_to("/")
    end



    def profile
        @user = User.find_by(id: params[:id])
        @profile_id = params[:id]
        #例：Like.where(id: [1,2,3])idの1,2,3を全て取得している。
        @user_profiles = Like.where(id: @user.like.split(",").map(&:to_i))
    end

    def profile_edit_form

    end

    def profile_edit
        @current_user.attributes = {name: params[:name],
                                    email: params[:email],
                                    password: params[:password],
                                    like: params[:like]}
        if @current_user.save
          flash[:notice] = "プロフィールの更新に成功しました。"
          redirect_to("/profile/#{@current_user.id}")
        else
          render("profile_edit_form")
        end
    end

    def new
        @user = User.new
    end

    def create
       @user = User.new(gender: params[:gender][:select],
                        email: params[:email],
                        password: params[:password],
                        name: params[:name],
                        age: params[:age],
                        like:"")
       if @user.save
       #新規作成と同時にログインする。
       session[:user_id] = @user.id
       flash[:notice] = "登録に成功しました"
       redirect_to("/")
       else

       render("new")
       end
    end

    def destroy
      User.find_by(id: params[:id]).destroy

      if session[:user_id] == 1
        Join.where(user_id: params[:id]).destroy
        redirect_to("/participant")
      else
        redirect_to("/")
      end
    end
end
