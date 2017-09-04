require 'statement_printer'
require 'date'

describe StatementPrinter do
  subject(:statement_printer) { described_class.new }
  let(:amount) { 500 }
  let(:balance) { 1000 }
  let(:amount_in_pounds) { format('%.2f', amount / 100.0) }
  let(:balance_in_pounds) { format('%.2f', balance / 100.0) }
  let(:transaction) { double('transaction', date: Date.today, amount: amount, balance: balance) }
  let(:today_date) { Date.today.strftime('%d/%m/%Y') }

  let(:empty_transactions) { [] }
  let(:mock_transactions) { [transaction, transaction] }
  let(:credit_transaction_output) { [today_date,
                                     ' || ' + amount_in_pounds + ' || ',
                                     ' || ' + balance_in_pounds].join('')
  }
  let(:debit_transaction_output) { [today_date,
                                  ' ||  || ' + amount_in_pounds,
                                  ' || ' + balance_in_pounds].join('')
  }
  let(:expected_statement) { ['date || credit || debit || balance',
                              debit_transaction_output,
                              credit_transaction_output].join("\n")
  }
  let(:empty_statement) { "date || credit || debit || balance\n" }

  describe '#print_transaction' do
    it 'prints a credit transaction in a pretty format' do
      allow(transaction).to receive(:type).and_return(:credit)
      expect(statement_printer.print_transaction(transaction))
        .to eq(credit_transaction_output)
    end
    it 'prints a debit transaction in a pretty format' do
      allow(transaction).to receive(:type).and_return(:debit)
      expect(statement_printer.print_transaction(transaction))
        .to eq(debit_transaction_output)
    end
  end

  describe '#print_statement' do
    it 'prints the whole statement in a pretty format' do
      allow(transaction).to receive(:type).and_return(:debit, :debit, :credit, :credit)
      expect { statement_printer.print_statement(mock_transactions) }
        .to output(expected_statement).to_stdout
    end
    it 'can print an empty statement' do
      expect { statement_printer.print_statement(empty_transactions) }
        .to output(empty_statement).to_stdout
    end
  end
end
