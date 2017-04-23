require 'httparty'

class Recipe
	include HTTParty

	ENV['FOOD2FORK_KEY'] = "ae3d3a52b6bdd2bead7a66b4c5522de2"
	key_value = ENV['FOOD2FORK_KEY']
    hostport = ENV['FOOD2FORK_SERVER_AND_PORT'] || 'www.food2fork.com'

    base_uri "http://#{hostport}/api"
    default_params key: key_value
    format :json

    def self.for (keyword)
    	get("/search",query:{q:keyword})["recipes"]
    end
end







