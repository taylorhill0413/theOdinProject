require_relative '../lib/board'

describe Board do
  subject(:board) { described_class.new }

  it 'Create board game' do
    expect(board.grid).not_to be_empty
  end
end
