class Like < ApplicationRecord
    validates :image, :title,{presence: true}

    def self.serach(serach)
      return all if serach == ""
      Like.where("permission = ? and title like ?", true,"%#{serach}%")
    end
end
