class Book < ApplicationRecord
	validates :title, presence: true
	# 空欄ではないこと
	validates :body, length: { maximum: 200}
	# 200文字以下
  	validates :body, presence: true
  	# 空欄ではないこと
	belongs_to :user
	# attachment :image
end
