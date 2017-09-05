require 'statement_line'

describe StatementLine do
  let(:amount) { 1000 }
  let(:balance) { 2000 }
  let(:display_amount) { format('%.2f', amount / 100.0) }
  let(:display_balance) { format('%.2f', balance / 100.0) }
  let(:today_date) { Date.today.strftime('%d/%m/%Y') }
  let(:transaction) do
    double('transaction', date: Date.today, amount: amount, balance: balance)
  end

  subject(:statement_line) { StatementLine.new }

  describe '#print' do
    context 'credit transaction' do
      let(:credit_transaction_output) do
        "#{today_date} || #{display_amount} ||  || #{display_balance}"
      end

      it 'prints a credit transaction in a pretty format' do
        allow(transaction).to receive(:type).and_return(:credit)
        expect(statement_line.print(transaction))
          .to eq(credit_transaction_output)
      end
    end

    context 'debit transaction' do
      let(:debit_transaction_output) do
        "#{today_date} ||  || #{display_amount} || #{display_balance}"
      end

      it 'prints a debit transaction in a pretty format' do
        allow(transaction).to receive(:type).and_return(:debit)
        expect(statement_line.print(transaction))
          .to eq(debit_transaction_output)
      end
    end
  end
end
