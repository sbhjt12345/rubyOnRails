class Place
  include ActiveModel::Model
  include Mongoid::Document

  attr_accessor :id, :formatted_address, :location, :address_components

  def initialize hashkeys
  	@id = hashkeys[:_id].to_s
  	@formatted_address = hashkeys[:formatted_address]
  	@location = Point.new hashkeys[:geometry][:geolocation]
  	if hashkeys[:address_components]
  		@address_components = hashkeys[:address_components].map {|r| AddressComponent.new r}
  	end
  end


  def self.mongo_client
  	Mongoid::Clients.default
  end

  def self.collection
    self.mongo_client['places']
  end

  def persisted?
    !@id.nil?
  end

  def self.load_all (file_path)
  	file = File.read(file_path)
  	jsonFile = JSON.parse(file)
  	self.collection.insert_many(jsonFile)
  end

  def self.find_by_short_name input
  	self.collection.find(:'address_components.short_name' => input)
  end

  def self.to_places inputs
  	res = []
  	inputs.map{|r| res << Place.new(r)}
  	return res
  end


  def self.find id
    bson_id = BSON::ObjectId.from_string id
    document = collection.find(:_id => bson_id).first
    Place.new document if document
  end

  def self.all(skip=0,limit=nil)
  	res = collection.find.skip(skip)
  	unless limit.nil?
  		res = res.limit(limit)
  	end
  	return res.map {|r| Place.new r}
  end

  def destroy 
  	bson_id = BSON::ObjectId.from_string id
  	self.class.collection.find(:_id => bson_id).delete_one()
  end

  def self.get_address_components (sort={:_id=>1},offset = 0, limit = nil)
  	ppl = [
  		{:$unwind => "$address_components"},
  		{:$project =>{
  			:address_components => 1,
  			:formatted_address => 1,
  			:'geometry.geolocation' => 1}
  		},
  		{:$sort => sort},
  		{:$skip => offset}
  		]
    ppl<<{:$limit => limit} unless limit.nil?
    return collection.find.aggregate(ppl)
   end

   def self.get_country_names
   	coll = collection.find.aggregate([

   		{:$project=>
   		    {
   		    	:'address_components.long_name' => 1,
   		    	:'address_components.types' => 1}},
   		{:$unwind => '$address_components'},
   		{:$match =>
   		   {:'address_components.types' => "country"}},
   		{:$group => {:_id => "$address_components.long_name"}}

   		])
   	col_arr = coll.map { |r| r[:_id]}
   end

   def self.find_ids_by_country_code  country_code
   	collection.find.aggregate([
   		{:$match => {
   			:'address_components.short_name' => country_code,
   			:'address_components.types' => "country"
   			}},
   		{:$project => {
   			:_id => 1
   			}}
   		]).map {|doc| doc[:_id].to_s}
   end

   def self.create_indexes
   	collection.indexes.create_one({
   		:'geometry.geolocation' => Mongo::Index::GEO2DSPHERE
   		})
   end

   def self.remove_indexes
   	collection.indexes.drop_one ('geometry.geolocation_2dsphere')
   end

   def self.near (point,max_meters=0)
   	q = {:$geometry => point.to_hash}
   	q[:$maxDistance] = max_meters unless max_meters.zero?
   	collection.find(:'geometry.geolocation' => {:$near => q})
   end

   def near max_meter=0
   	 docs = self.class.near(@location,max_meter)
     self.class.to_places docs
    end

    def photos (skip=0,limit=nil)
      res = Photo.find_photos_for_place(@id).skip(skip)
      res = res.limit(limit) unless limit.nil?
      res.map {|r| Photo.new r}
    end
      
    



end
