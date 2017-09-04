class Account
  attr_reader :balance
  def initialize
    @balance = 0
  end

  def deposit(amount)
    increase_balance(amount)
  end

  private

  def increase_balance(amount)
    @balance += amount
  end
end
