class Song < ActiveRecord::Base

	validates :title, presence: true
	validates :title, uniqueness: true 
	# can I?: validates :title, uniqueness: true, :on => :create
	# validates :release_year, presence: true
	# validates :released, presence: true
	validates :artist_name, presence: true
	validate :not_in_future, :is_released

	def not_in_future
		if release_year
			if release_year > Date.today.year
				errors.add(:release_year, "cannot be in the future")
			end
		end
	end

	def is_released
		# if release_year exists && released == false
		if release_year && !released
			errors.add(:released, "a song with a release year must be released")
		elsif !release_year && released
			errors.add(:released, "a released song must have a release year")
		end
	end



end
