require 'spec_helper'
 
module Codebreaker
  describe GameInterface do
    describe "#run" do
      let(:game) { subject.instance_variable_get(:@game) }
      it "calls start for game" do
        game.stub(:attempts_count).and_return(0)
        expect(game).to receive(:start)
        subject.run
      end

      it "doesn't call check if attempts_count is 0" do
        game.stub(:attempts_count).and_return(0)
        expect(game).not_to receive(:check)
        subject.run
      end

      it "calls check for game" do
        subject.stub(:restart)
        subject.stub_chain(:gets, :chomp).and_return("1234")
        expect(game).to receive(:check).and_call_original.exactly(10).times
        subject.run
      end

      shared_examples "restarting game" do
        it "calls restart" do
          expect(subject).to receive(:restart).at_least(1)
          subject.run
        end
      end

      context "user wins" do
        before do
          game.stub(:generate_code).and_return("1234")
          subject.stub_chain(:gets, :chomp).and_return("1234")
        end

        it_behaves_like "restarting game"
      end

      context "user loses" do
        before do
          game.stub(:generate_code).and_return("3456")
          subject.stub_chain(:gets, :chomp).and_return("1234")
        end

        it_behaves_like "restarting game"
      end
    end
		
    describe "#restart" do

      it "answer y" do
        subject.stub_chain(:gets, :chomp).and_return("y")
        expect(subject).to receive(:run)
        subject.send(:restart)
      end

      it "answer n" do
        subject.stub_chain(:gets, :chomp).and_return("n")
        expect(subject).to receive(:save)
        subject.send(:restart)
      end
    end

    describe "#save" do

      it "answer y" do
        subject.stub_chain(:gets, :chomp).and_return("y", "username")
        expect(subject).to receive(:save_to_file)
        subject.send(:save)
      end
    end
  end
end