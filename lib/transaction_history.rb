class TransactionHistory
  attr_reader :transactions

  def initialize(transaction_class)
    @transactions = []
    @transaction_class = transaction_class
  end

  def credit(amount, balance)
    store(transaction_class.credit(amount, balance))
  end

  def debit(amount, balance)
    store(transaction_class.debit(amount, balance))
  end

  private

  def store(transaction)
    transactions << transaction
    transaction
  end

  attr_reader :transaction_class
  
end
