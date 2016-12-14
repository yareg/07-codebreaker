require 'spec_helper'

module Codebreaker
  RSpec.describe Game do

    describe 'Start game' do

      it 'generates secret code' do
        expect(subject.instance_variable_get(:@secret_code)).not_to be_empty
      end

      it 'generates 4 numbers secret code' do
        expect(subject.instance_variable_get(:@secret_code).size).to eq(4)
      end

      it 'saves secret code with numbers from 1 to 6' do
        expect(subject.instance_variable_get(:@secret_code)).to match(/^[1-6]+$/)
      end
    end

    describe 'Check answer' do
      secret_code = '1234'

      context "When secret code equal #{secret_code}" do

        before do
          subject.instance_variable_set(:@secret_code, secret_code)
        end
        [
          [ '1234', '++++' ], [ '4321', '----' ], [ '1122', '+-' ]
        ].each do |node|
          it "answer is #{node[0]}" do
            expect(subject.check_attempt(node[0])).to eq(node[1])
          end
        end
      end

    end


  end
end
