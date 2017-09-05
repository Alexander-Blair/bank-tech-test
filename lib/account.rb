class Account
  attr_reader :balance, :transactions
  def initialize(transaction_class, statement_printer)
    @balance = 0
    @transactions = []
    @transaction_class = transaction_class
    @statement_printer = statement_printer
  end

  def deposit(amount)
    change_balance(amount)
    store_transaction(transaction_class.credit(amount, balance))
  end

  def withdraw(amount)
    change_balance(-amount)
    store_transaction(transaction_class.debit(amount, balance))
  end

  def view_statement
    statement_printer.print_statement(transactions)
  end

  private

  attr_reader :statement_printer, :transaction_class

  def store_transaction(transaction)
    transactions << transaction
  end

  def change_balance(amount)
    raise 'Cannot be decimal amount' unless amount.is_a? Integer
    @balance += amount
  end

end
