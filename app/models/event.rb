class Event < ApplicationRecord
  validates :capacity,{presence: true}
  validates :date,{length:{minimum:2}}
  validates :date,{length:{maximum:1000}}
  validates :capacity, {numericality: true}
end
