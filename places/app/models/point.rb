class Point
  include Mongoid::Document

  attr_accessor :longitude, :latitude

  def initialize input
  	@longitude = input[:lng] || input[:coordinates][0]
  	@latitude = input[:lat] || input[:coordinates][1]
  end

  def to_hash
  	{:type=>"Point" , :coordinates=>[@longitude,@latitude]}
  end
end
