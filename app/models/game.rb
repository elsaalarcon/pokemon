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

    def get_pokemon(id)
      response    = Net::HTTP.get(URI("https://pokeapi.co/api/v2/pokemon/#{id}")).to_s
      parsed      = JSON.parse(response)
  
      pokename    = parsed['name']
      pokenumber  = parsed['id'] 
      
      pokesprite  = parsed['sprites']['other']['official-artwork']['front_default']
      
      poketypes   = parsed['types'].map { |v| v['type']['name'].capitalize }
      pokeheight  = format_info(parsed['height'], 'height')
      pokeweight  = format_info(parsed['weight'], 'weight')
  
      pokeabils   = format_info_list(parsed['abilities'], 'ability', 'name')
      pokeitems   = format_info_list(parsed['held_items'], 'item', 'name')
  
      return {
        'name'   => pokename,
        'num'    => pokenumber,
        'sprite' => pokesprite,
        'types'  => poketypes,
        'height' => pokeheight,
        'weight' => pokeweight,
        'abils'  => pokeabils,
        'items'  => pokeitems
      }
    end
  

    response
  end
end

def format_info(parsed_property, property)
  case property
  when "weight"
    converted = parsed_property / 4.536 
    rounded   = converted < 1 ? converted.round(1) : converted.round()
    formatted = rounded.to_s.concat(" lbs") 
  when "height"
    converted = parsed_property * 3.937 
    feet      = converted.round() / 12
    inches    = converted.round() % 12
    formatted = ""
    unless feet.zero?
      formatted.concat("#{feet.to_s}\'")
    end
    unless inches.zero?
      formatted.concat("#{inches.to_s}\"")
    end
  end

  return formatted
end

def format_info_list(parsed_property, sym1, sym2)
  formatted = parsed_property.map { |v| v[sym1][sym2].sub('-', ' ').capitalize }
  str_from_arr = formatted.empty? ? "None" : formatted.join(', ')

  return str_from_arr
end