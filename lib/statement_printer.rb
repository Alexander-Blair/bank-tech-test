class StatementPrinter
  TOP_ROW = 'date || credit || debit || balance'

  def initialize(statement_line)
    @statement_line = statement_line
  end

  def print_statement(transactions)
    all_transactions = transactions.reverse.map do |transaction|
      statement_line.print(transaction)
    end
    print [TOP_ROW, all_transactions].join("\n")
  end

  private

  attr_reader :statement_line
end
