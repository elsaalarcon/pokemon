# I use NET HTTP instead of HTTParty for learning porpuses
# and see how ruby module works without gem 
require 'net/http'
require 'json'
require 'pry'
require 'amazing_print'

# Interpolation with Net HTTP give multiple issues, I search in stackoverflow.
# https://stackoverflow.com/questions/20765414/string-interpolation-and-uri-parse-error
# but I wasn't happy with the answer, so I use the following code.
def client_choose(offset = 10, limit = 20)
  response = Net::HTTP.get(
    URI("https://pokeapi.co/api/v2/pokemon/?offset=#{offset}&limit=#{limit}")
    )
   
  JSON.parse(response)
end
