require_relative 'action'
require_relative 'item'
require_relative 'parser'
require_relative 'player'
require_relative 'room'
require_relative 'modules'
require 'awesome_print'

class Game
  include Findable

  attr_accessor :player, :rooms

  def initialize(parser)
    @rooms = {}
    parser.all_rooms.each {|room| @rooms[room.name] = room}
    @player = Player.new(self)
  end

  def get_input
    input = gets.chomp.downcase
    /^e$|^exit$/.match(input) ? exit : input
  end

  def intro
    "Welcome! Please enter your name."
  end

  def get_name
    player.name = player.get_input
  end

  def show_room
    player.current_room.show_room
  end

  def get_option
    case get_input
    when /^(north|south|east|west)$/
      if player.current_room.exits.keys.include?($1)
        room_name = player.current_room.exits[$1]
        player.enter_room(room_name)
      else
        puts "You can't go that way."
      end
    when /^look$/
      player.current_room.show_objects
    when /^take (.*)$/
      object = player.current_room.find(player.current_room.objects, $1)
      if object
        player.take_object(object)
        puts "Got #{object}."
      else
        puts "You can't take that object."
      end
    when /^drop (.*)$/
      object = player.find(inventory, $1)
      player.inventory.delete(object)
      puts "Dropped #{$1}."
    when /^i$|^inventory$/
      puts "Inventory:"
      player.inventory.each {|object| puts object.name}
    else
      puts "That action is not valid. Please try again."
      get_option
    end
  end

  # def execute(option)
  #   if %w[east, enter, north, south, exit].include?(option)
  #     show_room(options[option])
  #   elsif current.objects.include?(option)

  #   end
  # end

  def start!
    puts intro
    get_name
    player.enter_room
    loop {get_option}
  end
end

parser = Parser.new('../data/petite_cave.if')
game = Game.new(parser)
game.start!
