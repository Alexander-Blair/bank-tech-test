require 'statement_printer'
require 'date'

describe StatementPrinter do
  subject(:statement_printer) { described_class.new }
  let(:amount) { 50 }
  let(:balance) { 100 }
  let(:transaction) { double("transaction", date: Date.today, amount: amount, balance: balance) }
  let(:mock_transactions) { Array.new(credit_transaction, debit_transaction) }
  let(:credit_transaction_output) { [Date.today.strftime("%d/%m/%Y"),
                             " || " + sprintf("%.2f", amount) + " || ",
                             " || " + sprintf("%.2f", balance)].join("") }
 let(:debit_transaction_output) { [Date.today.strftime("%d/%m/%Y"),
                            " ||  || " + sprintf("%.2f", amount),
                            " || " + sprintf("%.2f", balance)].join("") }

  describe "#print_transaction" do
    it "prints a credit transaction in a pretty format" do
      allow(transaction).to receive(:type).and_return(:credit)
      expect(statement_printer.print_transaction(transaction)).
        to eq(credit_transaction_output)
    end
    it "prints a debit transaction in a pretty format" do
      allow(transaction).to receive(:type).and_return(:debit)
      expect(statement_printer.print_transaction(transaction)).
        to eq(debit_transaction_output)
    end
  end
end
