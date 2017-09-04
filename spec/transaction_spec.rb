require 'transaction'

describe Transaction do
  let(:amount) { 1000 }
  let(:balance) { 2000 }
  subject(:transaction) { described_class.new(amount, :credit, balance) }
  let(:debit_transaction) { described_class.new(amount, :debit, balance) }

  describe "#initialize" do
    it "is created with a date" do
      expect(transaction.date).to be_instance_of Date
    end
    it "is created with an amount" do
      expect(transaction.amount).to eq amount
    end
    it "is created with a balance" do
      expect(transaction.balance).to eq balance
    end
    context "credit transaction" do
      it "is created as a credit transaction" do
        expect(transaction.type).to eq :credit
      end
    end
    context "debit transaction" do
      it "is created as a debit transaction" do
        expect(debit_transaction.type).to eq :debit
      end
    end
  end
end
