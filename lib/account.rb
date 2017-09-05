class Account
  attr_reader :balance

  def initialize(transaction_history, statement_printer)
    @balance = 0
    @transaction_history = transaction_history
    @statement_printer = statement_printer
  end

  def deposit(amount)
    change_balance(amount)
    transaction_history.credit(amount, balance)
  end

  def withdraw(amount)
    change_balance(-amount)
    transaction_history.debit(amount, balance)
  end

  def view_statement
    statement_printer.print_statement(transactions)
  end

  private

  attr_reader :statement_printer, :transaction_history

  def transactions
    transaction_history.transactions
  end

  def change_balance(amount)
    raise 'Cannot be decimal amount' unless amount.is_a? Integer
    @balance += amount
  end
end
