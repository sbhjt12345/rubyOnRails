class Racer
  include Mongoid::Document

  attr_accessor :id, :number, :first_name, :last_name, :gender,
                  :group, :secs

  def self.mongo_client
  	db = Mongoid::Clients.default
  end


  def self.collection
      return mongo_client["racers"]
  end


    def self.all(prototype={}, sort={:number => 1}, skip=0, limit=nil)
    #find all racers that match the given prototype
    #sort them by the given hash criteria
    #skip the specified number of documents
    result = collection.find(prototype).sort(sort).skip(skip)

    #limit the number of documents returned if limit is specified
    #return the result
    unless limit.nil?
      result = result.limit(limit)
    end
    result
  end


end
