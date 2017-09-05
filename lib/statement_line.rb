class StatementLine
  def print(transaction)
    [
      transaction.date.strftime('%d/%m/%Y'),
      ' || ' + display(amount(transaction, :credit)),
      ' || ' + display(amount(transaction, :debit)),
      ' || ' + number_to_currency(transaction.balance)
    ].join('')
  end

  private

  def display(string)
    string || ''
  end

  def amount(transaction, type)
    number_to_currency(transaction.amount) if transaction.type == type
  end

  def number_to_currency(number)
    format('%.2f', number / 100.0)
  end
end
