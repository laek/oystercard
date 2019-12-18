require 'oystercard'

describe Oystercard do

let(:entry_station){ double :station }
let(:exit_station){ double :station }

let (:journey){ {entry_station: entry_station, exit_station: exit_station} }

  context "basic set up" do
    it "initialises a new instance of the class Oystercard" do
      expect(subject).to be_a Oystercard
    end

    it "has a balance of 0.00 initially" do
      expect(subject.balance).to eq 0
    end

    it "is initially not in a journey" do
      expect(subject.entry_station).to be nil
    end

    it "has an empty list of journeys by default" do
      expect(subject.journeys). to be_empty
    end
  end

  context "methods and constants" do
    it "responds to a method called top up" do
      expect(subject).to respond_to(:top_up)
    end

    it "allows the user to top up money to the card" do
      subject.top_up(10)
      expect(subject.balance).to eq 10
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

  context "when topped up" do
    before {subject.top_up(Oystercard::MAX_BALANCE)}

    it "raises an error when a user tries to top up the balance above £90" do
      expect {subject.top_up(1) }. to raise_error "Top up not possible, maximum balance of #{Oystercard::MAX_BALANCE} exceeded."
    end

    it "allows the user to touch in" do
      subject.touch_in(entry_station)
      expect(subject.in_journey?).to eq true
    end

    it "stores a journey" do
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.journeys).to include journey
    end
  end

  context "when topped up and in journey" do
    before {subject.top_up(Oystercard::MAX_BALANCE)}
    before {subject.touch_in(entry_station)}

      it "can touch out" do
        subject.touch_out(exit_station)
        expect(subject).not_to be_in_journey
      end

      it "charges fare when touching out" do
        expect{ subject.touch_out(exit_station)}.to change{ subject.balance }.by(-Oystercard::MINIMUM_CHARGE)
      end

      it "stores the entry station" do
        expect(subject.entry_station).to eq entry_station
      end

      it "stores exit station" do
        subject.touch_out(exit_station)
        expect(subject.exit_station).to eq exit_station
      end
    end

  context "when no balance" do
    it "raises an error when balance is below minimum balance" do
      expect{subject.touch_in(entry_station)}.to raise_error ("Please top up, you have insuffient balance")
    end
  end

end
