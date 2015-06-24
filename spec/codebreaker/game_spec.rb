require 'spec_helper'
 
module Codebreaker
  describe Game do
    context "#start" do
      let(:game) { Game.new }
      before do
        game.start
      end

      it "generates secret code" do
        expect(game.instance_variable_get(:@secret_code)).not_to be_empty
      end
      
      it "saves 4 numbers secret code" do
        expect(game.instance_variable_get(:@secret_code)).to have(4).items
      end

      it "saves secret code with numbers from 1 to 6" do
        expect(game.instance_variable_get(:@secret_code)).to match(/[1-6]+/)
      end
    end

    describe "#check" do

      it "check attempts" do
        subject.instance_variable_set(:@attempts_count, 0)
        expect(subject.check("1234")).to eq("You don't have attempts")
      end

      it "check valid" do
        subject.instance_variable_set(:@attempts_count, 10)
        expect(subject.check("ddhs")).to eq("Invalid guess format")
      end

      context "check code" do
        before do
        subject.instance_variable_set(:@attempts_count, 10)
        end

        it "++++" do
          subject.instance_variable_set(:@secret_code, "1234")
          expect(subject.check("1234")).to eq("++++")
        end

        it "++-" do
          subject.instance_variable_set(:@secret_code, "1133")
          expect(subject.check("1335")).to eq("++-")
        end

        it "+--" do
          subject.instance_variable_set(:@secret_code, "1125")
          expect(subject.check("2114")).to eq("+--")
        end
        
        it "++-" do
          subject.instance_variable_set(:@secret_code, "3123")
          expect(subject.check("3131")).to eq("++-")
        end

        it "----" do
          subject.instance_variable_set(:@secret_code, "2211")
          expect(subject.check("1122")).to eq("----")
        end

        it "----" do
          subject.instance_variable_set(:@secret_code, "3665")
          expect(subject.check("6356")).to eq("----")
        end

        it "" do
          subject.instance_variable_set(:@secret_code, "6622")
          expect(subject.check("3333")).to eq("")
        end

        it "+" do
          subject.instance_variable_set(:@secret_code, "1234")
          expect(subject.check("3333")).to eq("+")
        end

        it "--" do
          subject.instance_variable_set(:@secret_code, "1615")
          expect(subject.check("6556")).to eq("--")
        end

        it "---" do
          subject.instance_variable_set(:@secret_code, "6561")
          expect(subject.check("1615")).to eq("---")
        end
      end

      context "hint" do
          
        it "return hint if exist" do
          subject.instance_variable_set(:@hint, "**2*")
          expect(subject.hint).to eq("**2*")
        end

        it "return hint" do
          subject.stub(:rand).and_return(2)
          subject.instance_variable_set(:@secret_code, "1234")
          expect(subject.hint).to eq("**3*")
        end

      end
    end


  end
end