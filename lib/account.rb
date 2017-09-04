class Account
  attr_reader :balance, :transactions
  def initialize(transaction_builder, statement_printer)
    @balance = 0
    @transactions = []
    @transaction_builder = transaction_builder
    @statement_printer = statement_printer
  end

  def deposit(amount)
    raise 'Cannot deposit negative amount' if negative_amount?(amount)
    raise 'Cannot deposit decimal amount' unless amount.is_a? Integer
    increase_balance(amount)
    create_transaction(amount, :credit)
  end

  def withdraw(amount)
    raise 'Cannot withdraw negative amount' if negative_amount?(amount)
    raise 'Cannot withdraw decimal amount' unless amount.is_a? Integer
    decrease_balance(amount)
    create_transaction(amount, :debit)
  end

  def view_statement
    statement_printer.print_statement(transactions)
  end

  private

  attr_reader :statement_printer

  def increase_balance(amount)
    @balance += amount
  end

  def decrease_balance(amount)
    raise 'Insufficient funds' if insufficient_funds?(amount)
    @balance -= amount
  end

  def create_transaction(amount, type)
    transactions << @transaction_builder.new(amount, type, balance)
  end

  def negative_amount?(amount)
    amount < 0
  end

  def insufficient_funds?(amount)
    amount > balance
  end
end
