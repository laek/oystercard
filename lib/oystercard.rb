class Oystercard

  attr_reader :balance, :max_balance

  MAX_BALANCE = 90.00

  def initialize
    @balance = 0.00
    @max_balance = MAX_BALANCE
  end

  def top_up(amount)
    raise "Top up not possible, maximum balance of #{@max_balance} exceeded." if (@balance + amount) > @max_balance
    @balance += amount
  end

end
