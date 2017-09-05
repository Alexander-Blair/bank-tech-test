require 'transaction_history'

describe TransactionHistory do
  let(:amount) { 1000 }
  let(:balance) { 2000 }
  let(:mock_transaction_class) do
    class_double('Transaction', credit: double('transaction'), debit: double('transaction'))
  end

  subject(:transaction_history) { described_class.new(mock_transaction_class) }

  describe '#initialize' do
    it 'is created with an empty transactions array' do
      expect(transaction_history.transactions).to be_empty
    end
  end

  describe '#credit' do
    let(:credit_transaction) { transaction_history.credit(amount, balance) }

    it 'stores the transaction in its transaction array' do
      expect(transaction_history.transactions).to include(credit_transaction)
    end
  end

  describe '#debit' do
    let(:debit_transaction) { transaction_history.debit(amount, balance) }

    it 'stores the transaction in its transaction array' do
      expect(transaction_history.transactions).to include(debit_transaction)
    end
  end
end
