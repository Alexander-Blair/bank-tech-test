class Account
  attr_reader :balance
  def initialize
    @balance = 0
  end

  def deposit(amount)
    raise "Cannot deposit negative amount" if negative_amount?(amount)
    increase_balance(amount)
  end

  def withdraw(amount)
    raise "Cannot withdraw negative amount" if negative_amount?(amount)
    decrease_balance(amount)
  end

  private

  def increase_balance(amount)
    @balance += amount
  end

  def decrease_balance(amount)
    raise "Insufficient funds" if insufficient_funds?(amount)
    @balance -= amount
  end

  def negative_amount?(amount)
    amount < 0
  end

  def insufficient_funds?(amount)
    amount > balance
  end
end
