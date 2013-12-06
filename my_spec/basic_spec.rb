require_relative '../bin/player'
require_relative '../bin/item'
require_relative '../bin/room'
require_relative '../bin/parser'

parser = Parser.new('../data/petite_cave.if')
items = parser.all_items
rooms = parser.all_rooms

describe Player do
  let(:player) {Player.new("Nikki")}

  it 'should have a name' do
    expect(player.name).to eq("Nikki")
  end

  describe '#update inventory' do

  end

  describe '#get_input' do
    it 'should get user input' do
      player.stub(:gets) {"hello\n"}
      player.get_input

      expect(player.input).to eq("hello")
    end
  end
end

describe Room do
  let(:room) {rooms.select{|room| room.name == "building"}[0]}
  let(:room_items) {items.select {|item| /keys|lamp|food|water_bottle/.match(item.name)}} 

  it 'should have a name' do
    expect(room.name).to eq("building")
  end

  it 'should have a description' do
    expect(room.description).to eq("You are inside a building, a well house for a large spring.")
  end

  it 'should have a list of items' do
    first_item = room_items[0]
    second_item = room_items[1]

    expect(room.objects[0].name).to eq("keys")
    expect(room.objects[1].name).to eq("lamp")
  end
end

describe Item do
  let(:item) {items.detect {|item| item.name == "lamp"}}

  it 'should have a name' do
    expect(item.name).to eq("lamp")
  end

  it 'should have a description' do
    expect(item.description).to eq("There is a shiny brass lamp nearby.")
  end

  it 'should be accessible using any of its terms' do
  end
end