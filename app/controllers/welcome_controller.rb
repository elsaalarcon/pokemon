class WelcomeController < ApplicationController

  require './app/models/game.rb'

  def index
    @responses = Game.new.client_choose(params[:offset], params[:limit])
  end

  def show
    @pokemon = params[:id]
  end
end