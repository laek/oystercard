require 'oystercard'

describe Oystercard do

  it "initialises a new instance of the class Oystercard" do
    expect(subject).to be_a Oystercard
  end

  it "has a balance of 0.00 initially" do
    expect(subject.balance).to eq 0
  end

  describe "#top_up" do
    context "allows user to top up" do
      it "responds to a method called top up" do
        expect(subject).to respond_to(:top_up)
      end

      it "allows the user to top up money to the card" do
        subject.top_up(10)
        expect(subject.balance).to eq 10
      end

      it "has a maximum balance of £90" do
        expect(subject.max_balance).to eq 90.00
      end

      it "raises an error when a user tries to top up the balance above £90" do
        subject.top_up(90)
        expect {subject.top_up(1) }. to raise_error "Top up not possible, maximum balance of #{Oystercard::MAX_BALANCE} exceeded."
      end
    end

    describe "#deduct" do
      context "allows user to use balance to pay for trips" do
        
      end
    end
  end
end
