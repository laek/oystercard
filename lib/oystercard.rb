class Oystercard

  attr_reader :balance, :max_balance

  MAX_BALANCE = 90
  BALANCE_TO_TRAVEL = 1
  MINIMUM_CHARGE = 1

  def initialize
    @balance = 0.00
    @max_balance = MAX_BALANCE
    @currently_in_journey = false
  end

  def top_up(amount)
    raise "Top up not possible, maximum balance of #{@max_balance} exceeded." if (@balance + amount) > @max_balance
    @balance += amount
  end

  def touch_in
    raise "Please top up, you have insuffient balance" if @balance < BALANCE_TO_TRAVEL
    @currently_in_journey = true
  end

  def touch_out
    deduct(MINIMUM_CHARGE)
    @currently_in_journey = false
  end

  def in_journey?
    @currently_in_journey
  end

  private
  
    def deduct(amount)
      @balance -= amount
    end

end
