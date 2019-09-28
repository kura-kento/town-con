class User < ApplicationRecord
    validates :email,{uniqueness: true}
    validates :email, :password,{presence: true}
    validates :age, {numericality: true}
    validates :age, :numericality => {:greater_than => 17}
    validates :age,{length:{maximum:1000}}
end
