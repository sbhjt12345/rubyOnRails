class TodoItem < ActiveRecord::Base
  def self.completed
     TodoItem.where(completed:true).count  
  end

end
