class User < ApplicationRecord
            # Include default devise modules.
          #   devise :database_authenticatable, :registerable,
          #           :recoverable, :rememberable, :trackable, :validatable,
          #           :confirmable, :omniauthable
           
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  include DeviseTokenAuth::Concerns::User       

  validates_uniqueness_of :auth_token
  before_create :generate_authentication_token!


  
 # has_many :children, :class_name => "User", :foreign_key => "uid_parent"
 # belongs_to :parent, :class_name => "User"

  belongs_to :parent_user, class_name: 'User' , foreign_key: :uid_parent , optional: true
  has_many :children, class_name: 'User', foreign_key: :uid_parent

  has_many :tasks, dependent: :destroy

  def info

       "#{email} - #{created_at} - Token: #{Devise.friendly_token}"

  end     

  def generate_authentication_token!
       begin
       self.auth_token = Devise.friendly_token
       end while User.exists?(auth_token: auth_token)
  end     

end
