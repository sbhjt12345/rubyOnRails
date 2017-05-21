class AddressComponent
  include Mongoid::Document

  attr_reader :long_name, :short_name, :types

  def initialize hashkeys
  	@long_name = hashkeys[:long_name]
  	@short_name = hashkeys[:short_name]
  	@types = hashkeys[:types]
  end


end
