class Oystercard

  attr_reader :balance, :max_balance, :entry_station, :exit_station, :journeys, :journey

  MAX_BALANCE = 90
  BALANCE_TO_TRAVEL = 1
  MINIMUM_CHARGE = 1

  def initialize
    @balance = 0.00
    @max_balance = MAX_BALANCE
    @entry_station = nil
    @journeys = []
    @journey = {}
  end

  def top_up(amount)
    raise "Top up not possible, maximum balance of #{@max_balance} exceeded." if (@balance + amount) > @max_balance
    @balance += amount
  end

  def touch_in(entry_station)
    raise "Please top up, you have insuffient balance" if @balance < BALANCE_TO_TRAVEL
    @currently_in_journey = true
    @entry_station = entry_station
    @journey[:entry_station] = entry_station
  end

  def touch_out(exit_station)
    deduct(MINIMUM_CHARGE)
    @entry_station = nil
    @exit_station = exit_station
    @journey[:exit_station] = exit_station
    @journeys.push(@journey)
  end

  def in_journey?
    !!@entry_station
  end

  private

    def deduct(amount)
      @balance -= amount
    end

end
