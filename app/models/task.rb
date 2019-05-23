class Task < ApplicationRecord
  belongs_to :user
  
  #valida presença dos campos
  validates_presence_of :title, :user_id
 # validates :title, :user_id, presence: true
end
