require 'spec_helper'

module Codebreaker
  RSpec.describe Menu  do
    describe '#main_menu' do
      context 'when user chooses "New game"' do
        it do
          allow(subject).to receive(:gets).and_return(described_class.const_get(:NEW_GAME).to_s)
          expect(subject.main_menu).to eq(described_class.const_get(:NEW_GAME))
        end
      end

      context 'when user chooses "Load saved results"' do
        it do
          allow(subject).to receive(:gets).and_return(described_class.const_get(:LOAD_SAVED).to_s)
          expect(subject.main_menu).to eq(described_class.const_get(:LOAD_SAVED))
        end
      end

      context 'when user chooses "quit"' do
        it do
          allow(subject).to receive(:gets).and_return(described_class.const_get(:QUIT).to_s)
          expect(subject.main_menu).to eq(described_class.const_get(:QUIT))
        end
      end
    end

    describe '#save_game_menu' do
      context 'when user types "yes"' do
        it do
          allow(subject).to receive(:gets).and_return('yes')
          expect(subject.save_game_menu).to eq(described_class.const_get(:SAVE_GAME))
        end
      end

      context 'when user types "no"' do
        it do
          allow(subject).to receive(:gets).and_return('no')
          expect(subject.save_game_menu).to eq(described_class.const_get(:DO_NOT_SAVE_GAME))
        end
      end
    end

    describe '#get_player_name' do
      context 'when user types his name' do
        it do
          user_name = 'New user name'
          allow(subject).to receive(:gets).and_return(user_name)
          expect(subject.get_player_name).to eq(user_name)
        end
      end
    end
  end
end