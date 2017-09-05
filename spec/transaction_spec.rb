require 'transaction'

describe Transaction do
  let(:amount) { 1000 }
  let(:balance) { 2000 }

  subject(:transaction) { described_class.credit(amount, balance) }

  describe '#initialize' do
    it 'is created with a date' do
      expect(transaction.date).to be_instance_of Date
    end

    it 'is created with an amount' do
      expect(transaction.amount).to eq amount
    end

    it 'is created with a balance' do
      expect(transaction.balance).to eq balance
    end
  end

  describe '.credit' do
    it 'creates a credit transaction' do
      expect(transaction.type).to eq :credit
    end
  end

  describe '.debit' do
    subject(:debit_transaction) { described_class.debit(amount, balance) }

    it 'creates a debit transaction' do
      expect(debit_transaction.type).to eq :debit
    end
  end
end
