require_relative 'modules'

class Room
  include Findable

  attr_reader :name, :description, :objects, :exits
  attr_writer :objects, :exits

  def initialize(name, description, objects, exits=[])
    @name = name
    @description = description
    @objects = objects
    @exits = exits
  end

  def add_object(object)
    objects << object
  end

  def add_exit(exit)
    exits << exit
  end

  def show_room
    puts description
  end

  def show_objects
    if objects.empty?
      puts "The room is empty."
    else
      objects.each {|object| puts "There is a #{object.name} on the floor."}
    end
  end
end