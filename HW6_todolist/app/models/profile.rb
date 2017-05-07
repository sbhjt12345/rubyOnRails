class Profile < ActiveRecord::Base
	belongs_to :user


	validate :one_name
	validate :weird_gender_validator
	validates :gender, inclusion: { in: ["male", "female"]}

	def one_name
		if !first_name && !last_name
			errors.add(:first_name, "Both names can't be empty")
		end
	end

	def weird_gender_validator
		if gender == 'male' && first_name == "Sue"
			errors.add(:first_name, "How do you do. Boys aren't named Sue, Johnny cash blah blah blah.")
		end
	end

	def self.get_all_profiles (min_birth_year, max_birth_year)
		Profile.where("birth_year BETWEEN ? AND ?", "#{min_birth_year}", "#{max_birth_year}").order(birth_year: :asc)
	end
end
