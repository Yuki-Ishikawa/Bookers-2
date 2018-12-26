class User < ApplicationRecord

  validates :name, length: { minimum:2, maximum: 20}
	# 2文字以上20文字以下
  validates :name, presence: true
  	# 空欄ではないこと
  validates :introduction, length: { maximum: 50}
  	# 50文字以下

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy

  attachment :profile_image

end
