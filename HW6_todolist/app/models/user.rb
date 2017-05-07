class User < ActiveRecord::Base
	has_one :profile, dependent: :destroy
	has_many :todo_lists, dependent: :destroy
	has_many :todo_items, through: :todo_lists, source: :todo_items

	validates :username, presence: true
	has_secure_password

	def get_completed_count
		completed_count = 0
		self.todo_lists.each{ |list| list.todo_items.where(completed: true).each{completed_count += 1}}
		completed_count
	end
end
