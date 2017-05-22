class Photo
  include Mongoid::Document

  attr_accessor :id, :location
  attr_writer :contents
  #id is string, location is point

  def self.mongo_client
     Mongoid::Clients.default
  end



  def initialize (params={})
  	@id = params[:_id].to_s unless params[:_id].nil?
  	if params[:metadata] && params[:metadata][:location] 
  		@location = Point.new params[:metadata][:location] 
    end
    @place = params[:metadata][:place] if params[:metadata] && params[:metadata][:place]
  end

  def persisted?
  	!@id.nil?
  end

  def place 
  	@place.nil? ? nil : Place.find(@place)
  end

  def place=(value)
  	@place = case value
  	when BSON::ObjectId
  		value
  	when String
  		BSON::ObjectId.from_string value
  	when Place
  		BSON::ObjectId.from_string value.id
  	when nil
  		nil
  	end
  end

  def self.find_photos_for_place placeId
  	pd = placeId 
     if placeId.is_a?(String)
     	pd = BSON::ObjectId.from_string placeId
     end
    mongo_client.database.fs.find(:'metadata.place' => pd)
  end


    

  def save
  	description = {}
  	if !persisted?
  	  file = @contents
      gps = EXIFR::JPEG.new(file).gps
      file.rewind
      # grab gps with exfir gem from file stored in @contents
      @location = Point.new lng: gps.longitude, lat: gps.latitude
      content_type = 'image/jpeg'
      description[:content_type] = content_type
      description[:metadata] = { location: @location.to_hash, place: @place }
      grid_file = Mongo::Grid::File.new file.read, description
      grid_doc_id = self.class.mongo_client.database.fs.insert_one(grid_file)
      @id = grid_doc_id.to_s
    else
      description[:metadata] = {location: @location.to_hash, place: @place}
      self.class.mongo_client.database.fs
      .find(:_id => BSON::ObjectId.from_string(@id))
      .update_one(description)
    end
   end

   def self.all (skip=0,limit=nil)
   	res = mongo_client.database.fs.find.skip(skip)
   	res = res.limit(limit) unless limit.nil?
   	res.map {|r| Photo.new r}
   end

   def self.find sid
   	bson_id = BSON::ObjectId.from_string sid
   	res = mongo_client.database.fs.find(:_id => bson_id).first
   	if !res.nil?
       @id = res[:_id].to_s
   	   @location = res[:metadata][:location]
   	   return Photo.new res
   	else return nil
   	end
   end

   def contents
   	f = self.class.mongo_client.database.fs.find_one(:_id => BSON::ObjectId.from_string(@id))
   	if f
   		buffer = ""
   		f.chunks.reduce([]) do |x,chunk|
   			buffer << chunk.data.data
   		end
   		return buffer
   	end
   end

   def destroy 
   	self.class.mongo_client.database.fs.find(:_id => BSON::ObjectId.from_string(@id)).delete_one
   end

   def find_nearest_place_id max_meters
   	Place.near(@location,max_meters).limit(1).projection(:_id=>1).first[:_id]||nil
   end





end
