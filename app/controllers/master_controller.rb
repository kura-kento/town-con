class MasterController < ApplicationController

  before_action :master_acsess

  def top
      @events = Event.where("date > ?", Date.yesterday).order(date: "asc")
      @joins = Join.all
  end

  def likes
      @likes = Like.all
      session[:time] = Time.now
  end

  def likes_destroy
      Like.find_by(id: params[:id]).destroy
      redirect_to("/master/likes")
  end

  def likes_permission
      likes = Like.where(created_at: "2018-01-01 00:00:00"..session[:time])
      likes.each{ |like|
                  like.permission = true
                  like.save
                  user = User.find_by(id: like.creator_id)
                  user.like << "#{like.id},"
                  user.save
                  }
      redirect_to("/master/likes")
  end

  def event_add
      event = Event.new(date: params[:date],capacity:params[:capacity])
      flash[:notice] = event.save ? "日程を追加しました。" : "入力が間違っています。"
      redirect_to("/master")
  end

  def event_destroy
      Event.find_by(date: params[:date]).destroy
      redirect_to("/master")
  end

  def event_deadline
      event = Event.find_by(date: params[:date])
      event[params[:gender].to_sym] = !(event[params[:gender].to_sym])
      event.save
      redirect_to("/master")
  end

  def participant
      #履歴は別ページにする（未定）
      @events = Event.where("date > ?", Date.yesterday).order(date: "asc")
      @events_old = Event.where("date <= ?", Date.yesterday).order(date: "asc")
  end

  def participant_date
      @events = Event.where("date > ?", Date.yesterday).order(date: "asc")
      @events_old = Event.where("date <= ?", Date.yesterday).order(date: "asc")
      #serachはmodelsのjoinに定義
      @participants = Join.serach(params[:date])
      @date = params[:date]
      unless @participants == nil
          @participants_man = @participants.where(gender: "男性")
          @participants_woman = @participants.where(gender: "女性")
      end
  end

  def matching
      man_users = Join.users("男性",params[:date])
      woman_users = Join.users("女性",params[:date])

      #setsは[[男性のid,女性のid],[男性のid,女性のid]]の全ての組み合わせ
      sets = woman_users.map(&:id).product(man_users.map(&:id)).collect{|set|set}

      sets.each{|set|
          woman_profile = User.find_by(id: set[0]).like.split(",")
          man_profile = User.find_by(id: set[1]).like.split(",")

          if  Match.find_by(user_id: set[0],matched_id: set[1]) != nil
              set << -100
          else
              #趣味が同じ人はその数だけ点数がつく
              set << (woman_profile & man_profile).size
          end
      }
      # マッチング combinations = []
      combinations = []
      woman_users.size.times{|i|
          set_number = 0
          combinations  <<   woman_users.size.times.map{|j|
              if j == 0
                  set_number = set_number + i
              elsif  (set_number+1)%(woman_users.size) == 0
                  set_number = set_number + 1
              else
                  set_number = set_number + (woman_users.size+1)
              end
              sets[set_number]
          }
      }
      com_sum = combinations.map{|combination| combination.transpose[2].sum }
      (params[:time]).to_i.times{

          combination_max_number = com_sum.find_index(com_sum.max)

          #全体の席の並び（idごとに席が変わる6~8回）
          pair = Pair.create(men: combinations[combination_max_number].inject(""){ |sum,combination| sum + "#{combination[1]},"},
                            women: combinations[combination_max_number].inject(""){|sum,combination| sum + "#{combination[0]},"},

                            date: params[:date])
          #誰が誰とペアになったか（個人ごとに）
          man_users.size.times{|i|
              Match.create(matched_id: combinations[combination_max_number][i][0],
              user_id: combinations[combination_max_number][i][1],
              date: params[:date])
          }
          com_sum[combination_max_number] = -10000
      }

      redirect_to("/participant/#{params[:date]}")
    end

  def matched_destroy
      Match.where(date: params[:date]).each(&:destroy)
      Pair.where(date: params[:date]).each(&:destroy)
      redirect_to("/participant/#{params[:date]}")
  end

  def grest_add
      count = User.all.count{|user| user.id < 0 }
      gender = params[:gender] == "man" ?  "男性" : "女性"
      User.create(id: -(count+1), gender: gender , name: "ゲスト#{-count+1}" ,email: -(count+1),password:  -(count+1) ,age: 20,like: "")
      Join.create(user_id: -(count+1), gender: gender,date: params[:date])
      redirect_to("/participant/#{params[:date]}")
  end
end
