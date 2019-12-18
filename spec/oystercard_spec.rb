require 'oystercard'

describe Oystercard do

  context "basic set up" do
    it "initialises a new instance of the class Oystercard" do
      expect(subject).to be_a Oystercard
    end

    it "has a balance of 0.00 initially" do
      expect(subject.balance).to eq 0
    end

    it "is initially not in a journey" do
      expect(subject).not_to be_in_journey
    end
  end

  it "allows the user to top up money to the card" do
    subject.top_up(10)
    expect(subject.balance).to eq 10
  end

  context "methods and constants" do
    it "responds to a method called top up" do
      expect(subject).to respond_to(:top_up)
    end

    it "responds to a method called touch_in" do
      expect(subject).to respond_to(:touch_in)
    end

    it "responds to a method called touch out" do
      expect(subject).to respond_to(:touch_out)
    end

    it "responds to a method called in_journey?" do
      expect(subject).to respond_to(:in_journey?)
    end

    it "has a maximum balance of £90" do
      expect(subject.max_balance).to eq 90.00
    end

    #it "has a minimum balance of £1 for touching in" do
  end

  context "when card has been topped up" do
   before {subject.top_up(Oystercard::MAX_BALANCE)}

      it "raises an error when a user tries to top up the balance above £90" do
        expect {subject.top_up(1) }. to raise_error "Top up not possible, maximum balance of #{Oystercard::MAX_BALANCE} exceeded."
      end

      it "allows the user to touch in" do
        subject.touch_in
        expect(subject.in_journey?).to eq true
      end

      it "can touch out" do
        subject.touch_in
        subject.touch_out
        expect(subject).not_to be_in_journey
      end

      it "charges fare when touching out" do
        subject.touch_in
        expect{ subject.touch_out}.to change{ subject.balance }.by(-Oystercard::MINIMUM_CHARGE)
      end
    end

  context "when card has no balance" do
    it "raises an error when balance is below minimum balance" do
      expect{subject.touch_in}.to raise_error ("Please top up, you have insuffient balance")
    end
  end
end
