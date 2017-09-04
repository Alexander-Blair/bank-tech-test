require 'date'

class Transaction
  attr_reader :date, :amount, :type, :balance
  def initialize(amount, type, balance)
    @date = Date.today
    @amount = amount
    @type = type
    @balance = balance
  end
end
