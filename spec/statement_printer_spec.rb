require 'statement_printer'
require 'date'

describe StatementPrinter do
  subject(:statement_printer) { described_class.new }
  let(:amount) { 500 }
  let(:balance) { 1000 }
  let(:amount_in_pounds) { format('%.2f', amount / 100.0) }
  let(:balance_in_pounds) { format('%.2f', balance / 100.0) }
  let(:transaction) do
    double('transaction', date: Date.today, amount: amount, balance: balance)
  end
  let(:mock_transactions) { [transaction, transaction] }

  describe '#print_statement' do
    context 'statement with transactions' do
      let(:today_date) { Date.today.strftime('%d/%m/%Y') }
      let(:expected_statement) do
        ['date || credit || debit || balance',
          debit_transaction_output,
          credit_transaction_output].join("\n")
        end
        let(:credit_transaction_output) do
          [today_date,
            ' || ' + amount_in_pounds + ' || ',
            ' || ' + balance_in_pounds].join('')
          end
          let(:debit_transaction_output) do
            [today_date,
              ' ||  || ' + amount_in_pounds,
              ' || ' + balance_in_pounds].join('')
            end
        it 'prints the whole statement in a pretty format' do
          allow(transaction).to receive(:type).and_return(:debit, :debit, :credit, :credit)
          expect { statement_printer.print_statement(mock_transactions) }
          .to output(expected_statement).to_stdout
        end
    end
    context 'empty statement' do
      let(:empty_transactions) { [] }
      let(:empty_statement) { "date || credit || debit || balance\n" }
      it 'can print an empty statement' do
        expect { statement_printer.print_statement(empty_transactions) }
        .to output(empty_statement).to_stdout
      end
    end
  end
end
