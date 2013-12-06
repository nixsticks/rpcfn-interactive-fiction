require_relative 'modules'

class Player
  include Findable 

  attr_accessor :game, :name, :inventory, :current_room
  attr_reader :input

  def initialize(game)
    @game = game
    @inventory = []
    @current_room
  end

  def get_input
    input = gets.chomp.downcase
    /^e$|^exit$/.match(input) ? exit : @input = input
  end

  def take_object(object)
    object << inventory
  end

  def enter_room(room="end_of_road")
    @current_room = game.rooms[room]
    @current_room.show_room
    @current_room.show_objects
  end
end