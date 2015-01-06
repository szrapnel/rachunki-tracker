class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
#   TODO config
  #   w zasadzie to zrob po prostu limit userow na 1 i bedzie spoko tez
  validates :email, inclusion: { in: %w(szrapnel@poczta.onet.pl),
    message: "this is not a valid email" }, on: :create
end
