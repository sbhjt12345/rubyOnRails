class Profile < ActiveRecord::Base
  belongs_to :user

  validate :either_name_is_null 
  validates :gender, inclusion: ['male','female']
  validate :no_man_is_sue


  def either_name_is_null
  	if (first_name==nil && last_name==nil) 
  		errors.add(:first_name, "should not be both null")
  	end
  end

  def no_man_is_sue
  	if (first_name=='Sue' && gender=='male')
  		errors.add(:first_name,"no man should be called Sue")
  	end
  end

  def self.get_all_profiles (minAge,maxAge)
  	profiles = Profile.where("birth_year BETWEEN ? AND ?",minAge,maxAge).order(birth_year: :asc)
  end

  


end
