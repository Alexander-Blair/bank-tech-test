require 'date'

class Transaction
  attr_reader :date, :amount, :type, :balance

  def self.debit(amount, balance)
    initialize(amount, :debit, balance)
  end

  def self.credit(amount, balance)
    initialize(amount, :credit, balance)
  end

  def initialize(amount, type, balance)
    @date = Date.today
    @amount = amount
    @type = type
    @balance = balance
  end
end
