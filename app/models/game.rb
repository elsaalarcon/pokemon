class Game
# I use NET HTTP instead of HTTParty for learning porpuses
# and see how ruby module works without gem 
require 'net/http'
require 'json'
require 'amazing_print'

# Interpolation with Net HTTP give multiple issues, I search in stackoverflow.
# https://stackoverflow.com/questions/20765414/string-interpolation-and-uri-parse-error
# but I wasn't happy with the answer, so I use the following code.
  def client_choose(offset = 0, limit = 20)
    responses = Net::HTTP.get(
      URI("https://pokeapi.co/api/v2/pokemon/?offset=#{offset}&limit=#{limit}")
    )
   
    response = JSON.parse(responses)
     response['results'].map! do |pokemon|
      pokemon.merge({id: pokemon['url']
        .split('https://pokeapi.co/api/v2/pokemon/')
        .join('')
        .split('/')
        .first
        .to_i })
    end

    response
  end
end