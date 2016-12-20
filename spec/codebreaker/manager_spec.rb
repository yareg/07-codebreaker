require 'spec_helper'

module Codebreaker
  RSpec.describe Manager do
    describe '#initialize' do
      # context 'init Manager object' do
      #   # before(:example) do
      #   #   subject.initialize
      #   # end
      #
      #   it  do
      #     allow(subject).to receive(:gets).and_return('3')
      #     subject.initialize
      #
      #     # expect(subject.user_menu).not_to be_nil
      #   end
      # end


    end

    describe '#process_choise' do
      context 'when user made choice' do
        it do

          expect(subject.send(:quit)).to output(/bye/i).to_stdout
        end
      end
    end
  end
end