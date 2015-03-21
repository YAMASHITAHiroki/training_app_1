class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :nickname, presence: true, length: { maximum: 20, allow_blank: true }, uniqueness: { case_sensitive: false }
  has_many :microposts, dependent: :destroy

end
