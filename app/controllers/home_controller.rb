class HomeController < ApplicationController

    before_action :acsess

    def top
        @events = Event.where("date > ?", Date.today).order(date: "asc")
        @joins = Join.all
        @users = User.all
    end

    def join_form
        @events = Event.where("date > ?", Date.today).order(date: "asc")
        @joins = Join.all
    end

    def join
        unless params[:date].empty?
            @join = Join.new(user_id: @current_user.id,
                             gender: @current_user.gender,
                             date: params[:date])
            @join.save
        end
        redirect_to("/join_form")
    end

    def cancel
        Join.find_by(user_id: session[:user_id], date: params[:date]).destroy
        redirect_to("/")
    end

    def likes
        @likes = Like.all.order(peple: "desc")
    end

    def like_serach
        @like_serach = Like.serach(params[:serach]).order(peple: "desc")
    end

    def like_add_form
        @likes = Like.all
    end

    def like_add
        if params[:image] != nil  && params[:title] != ""
            image_id = Like.last == nil ? 1 : Like.last.id + 1
            @like = Like.create(title: params[:title],image: "#{image_id}.jpg",creator_id: session[:user_id])

            File.binwrite("public/like_images/#{@like.image}", params[:image].read)
            flash[:notice] = "追加しました。"
            redirect_to("/likes")
        else
            @error_message = "タイトルまたは画像がありません"
            @title = params[:title]
            render("like_add_form")
        end
    end

    def like
       @like = Like.find_by(id: params[:id])
    end

    def like_profile_add
        @current_user.like << "#{params[:id]},"
        @current_user.save
        like = Like.find_by(id: params[:id])
        like.peple += 1
        like.save
        redirect_to("/likes")
    end

    def like_profile_destroy
        user_like = @current_user.like.split(",")
        user_like.delete("#{params[:id]}")
        @current_user.like = user_like.inject(""){|sum,i|  sum + i + ","}
        @current_user.save
        like = Like.find_by(id: params[:id])
        like.peple -= 1
        like.save
        redirect_to("/likes")
    end


end
