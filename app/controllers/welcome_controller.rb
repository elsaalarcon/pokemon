class WelcomeController < ApplicationController
  require 'will_paginate/array'
  def index
    response = HTTParty.get('https://pokeapi.co/api/v2/pokemon/150')
    @response = response["moves"].collect { |move| move['move']["name"] }
  end
end