require 'statement_printer'
require 'date'

describe StatementPrinter do
  let(:transaction) { double('transaction') }
  let(:mock_transactions) { [transaction, transaction] }
  let(:mock_statement_line) { double('statement_line') }

  subject(:statement_printer) { described_class.new(mock_statement_line) }

  describe '#print_statement' do
    context 'statement with transactions' do
      let(:mock_credit_transaction) { "credit transaction" }
      let(:mock_debit_transaction) { "debit transaction" }
      let(:expected_statement) do
        [
          described_class::TOP_ROW,
          mock_debit_transaction,
          mock_credit_transaction
        ].join("\n")
      end

      it 'asks the statement line to return each transaction as a string' do
        expect(mock_statement_line)
          .to receive(:print).exactly(mock_transactions.length).times
        statement_printer.print_statement(mock_transactions)
      end

      it 'prints the whole statement in a pretty format' do
        allow(transaction).to receive(:type).and_return(:debit, :debit, :credit, :credit)
        allow(mock_statement_line).to receive(:print)
          .and_return(mock_debit_transaction, mock_credit_transaction)

        expect { statement_printer.print_statement(mock_transactions) }
          .to output(expected_statement).to_stdout
      end
    end

    context 'empty statement' do
      let(:empty_transactions) { [] }
      let(:empty_statement) { described_class::TOP_ROW + "\n" }

      it 'can print an empty statement' do
        expect { statement_printer.print_statement(empty_transactions) }
          .to output(empty_statement).to_stdout
      end
    end
  end
end
