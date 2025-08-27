require_relative '../lib/player'

describe Player do
  subject(:player) { described_class.new }

  xit 'create pawn moves' do
    pawn_move = [[0, 1], [0, 2], [1, 1], [-1, -1]]

    expect(player.instance_variable_get(:@PAWN_MOVES)).to eq(pawn_move)
  end

  it 'check valid move' do
    valid_move = [6, 5]
    expect(player.valid_move?(valid_move)).to be true
  end
end
