class StatementPrinter

  def print_statement(transactions)

  end

  def print_transaction(transaction)
    [transaction.date.strftime("%d/%m/%Y"),
     " || " + amount(transaction, :credit),
     " || " + amount(transaction, :debit),
     " || " + number_to_currency(transaction.balance)].join("")
  end

  private

  def amount(transaction, type)
    return '' unless transaction.type == type
    number_to_currency(transaction.amount)
  end

  def number_to_currency(number)
    sprintf("%.2f", number)
  end
end
