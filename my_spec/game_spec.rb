require_relative '../bin/player'
require_relative '../bin/item'
require_relative '../bin/room'
require_relative '../bin/parser'
require_relative '../bin/game'

describe Game do
  let(:parser) {Parser.new('../data/petite_cave.if')}
  let(:game) {Game.new(parser)}

  it 'should initialize with a list of rooms' do
    expect(game.rooms).to be_a_kind_of(Hash)
    expect(game.rooms[:building].name).to eq("building")
  end

  context 'when the game begins' do
    
  end

  context 'at the end of the road' do
    it 'should' do
    end
  end
end