class Join < ApplicationRecord

  def self.serach(serach)
    return nil unless serach
    Join.where(date: serach)
  end

  def self.users(gender,date)
      return Join.where(gender: gender,date: date).map{|i| User.find(i.user_id)}
  end

end
