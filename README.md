# rubyOnRails

HW1 : for getting familiar with ruby syntax

HW2 : a simple project to get search results displayed on a webpage.
      Used HTTParty gem
      Used Food2Fork API to get recipe
      What I do? 1. view and controller: in controller, first find if we define a search param, and use that param to apply into 
                                         the for function, which is defined in the recipe.rb in the model, in order to get the 
                                         result json query
                                         in view, just make result sing.
                                         
                 2. in routes, make recipe/index the root so we only need to input localhost3000/?search=XXXX
                 3. recipe.rb in model : ask httparty to do the connecting job for us from api to our local server(I guess.)
                                         we need a base_uri, a key value which is my api key, and a for function which implements 
                                         "get" to do the searching job.
                                         
                                        
HW3 : JUst how to generate scaffold/model and how to do CRUD through Active Record                                        
