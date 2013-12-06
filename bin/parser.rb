require 'ruby-debug'
require_relative 'item'
require_relative 'room'

class Parser
  attr_reader :file
  attr_accessor :rooms

  def initialize(file)
    @file = File.open(file, "r").read
    @rooms
  end

  def get_sections
    file.split(/\n\n/)
  end

  def name(object)
    object.scan(/Room @(.*):|\$(.*):|!(.*):/).flatten.compact[0]
  end

  def title(object)
    /Title: (.*)$/.match(object)[1]
  end

  def description(object)
    description = /Description:\W*([\w\s\t\-\?\!\.,]*)|Description: (.*)/.match(object)[1]
    description.gsub(/\s+/, " ").gsub(/\sExits/, "")
  end

  def terms(object)
    terms = /Terms: (.*)/.match(object)[1].split(", ")
    terms.map {|term| term.downcase}
  end

  def items_in_room(room)
    items = room.scan(/\$(\w+)*/).flatten
    items.empty? ? [] : items 
  end

  def exits(object)
    exit_hash = {}
    exits = object.scan(/Exits:([\W\w]*)/).flatten
    exits.delete("Exits:")
    exits = exits.map {|exit| exit.gsub(/^\s*/, "")}
    exits = exits.map {|exit| exit.split("\n")}.flatten
    exits.each do |exit|
      match = /(?<dir>.*) to @(?<room>.*)/.match(exit)
      exit_hash[match[:dir]] = match[:room] if match
    end
    exit_hash
  end

  def code(object)
    /\{{3}([\W\w]*)\}{3}/.match(object)[1]
  end

  def raw_rooms
    get_sections.select {|section| section if /^Room/.match(section)}
  end

  def raw_items
    get_sections.select {|section| section if /^Object\s/.match(section)}
  end

  def raw_actions
    get_sections.select {|section| section if /^Action/.match(section)}
  end

  def all_rooms
    @rooms = raw_rooms.map do |room|
      Room.new(name(room), description(room), items_in_room(room), exits(room))
    end
    set_items(@rooms)
  end

  def all_items
    raw_items.map {|item| Item.new(name(item), terms(item), description(item))}
  end

  def all_actions
    raw_actions.map {|action| Action.new(name(action), terms(action))}
  end

  def set_items(rooms)
    rooms.each do |room|
      objects = []
      room.objects.each {|object| objects << search_name(all_items, object)}
      room.objects = objects
    end
  end

  # def set_exits(rooms)
  #   rooms.each do |room|
  #     room.exits.each_pair do |dir, exit|
  #       exit = rooms.select {|room| room.name == exit}
  #     end
  #   end
  # end

  def search_name(list, name)
    list.detect {|object| object.name == name}
  end

  def synonyms
    get_sections.select{|section| /^Synonyms:/.match(section)}
  end
end

# Get room sections. Store in array.
# Make new room objects from each section. Get title, description, exits, objects, store in hash.
# Get object sections. Store in hash.
# For each room, go through and put the objects in its hash.
# Get synonyms.
# # Get actions.

# parser = Parser.new('../data/petite_cave.if')
# parser.all_rooms
# p parser.rooms