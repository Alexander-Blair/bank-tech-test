require 'transaction'

describe Transaction do
  let(:amount) { 1000 }
  let(:balance) { 2000 }

  describe '.credit' do
    subject(:transaction) { described_class.credit(amount, balance) }

    it 'is created as a credit transaction' do
      expect(transaction.type).to eq :credit
    end

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

  describe '.debit' do
    subject(:debit_transaction) { described_class.debit(amount, balance) }

    it 'is created as a debit transaction' do
      expect(debit_transaction.type).to eq :debit
    end
    it 'is created with a date' do
      expect(debit_transaction.date).to be_instance_of Date
    end

    it 'is created with an amount' do
      expect(debit_transaction.amount).to eq amount
    end

    it 'is created with a balance' do
      expect(debit_transaction.balance).to eq balance
    end
  end
end
