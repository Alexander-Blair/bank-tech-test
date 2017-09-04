class StatementPrinter

  def print_statement(transactions)
    all_transactions = transactions.reverse.each_with_object(Array.new) do |transaction, statement|
      statement << print_transaction(transaction)
    end
    print [generate_top_row, all_transactions].join("\n")
  end

  def print_transaction(transaction)
    [transaction.date.strftime("%d/%m/%Y"),
     " || " + amount(transaction, :credit),
     " || " + amount(transaction, :debit),
     " || " + number_to_currency(transaction.balance)].join("")
  end

  private

  def generate_top_row
    "date || credit || debit || balance"
  end

  def amount(transaction, type)
    return '' unless transaction.type == type
    number_to_currency(transaction.amount)
  end

  def number_to_currency(number)
    sprintf("%.2f", number / 100.0)
  end
end
