class WelcomeController < ApplicationController
  require 'will_paginate/array'
  def index
    response = HTTParty.get('https://pokeapi.co/api/v2/pokemon/150')
    body = response["moves"].collect { |move| move['move']["name"] }
    @response = body.paginate(:page => 3, :per_page => 10)
  end
end