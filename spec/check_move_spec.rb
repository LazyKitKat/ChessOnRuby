require 'spec_helper'
require_relative '../lib/module/check_move.rb'

RSpec.describe CheckMove do
    let(:dummy_class) { Class.new { extend CheckMove } }
    context 'when given a valid position' do
        it 'should return true' do
            test_pawn = dummy_class.valid_pawn_move?(1,1,2,1)
            expect(test_pawn).to be(true)
        end
    end
    context 'when given invalid move' do
        it 'should return false' do
            test_pawn = dummy_class.valid_pawn_move?(1,1,1,2)
            expect(test_pawn).to be(false)
        end
    end
end