require 'account'

describe Account do
  subject(:account) { described_class.new }
  let(:deposit_amount) { 100 }
  let(:withdraw_amount) { 25 }
  let(:insufficient_funds_error) { "Insufficient funds" }
  let(:negative_deposit_error) { "Cannot deposit negative amount" }
  let(:negative_withdrawal_error) { "Cannot withdraw negative amount" }

  describe "#initialize" do
    it "begins with a balance of 0" do
      expect(account.balance).to eq 0
    end
  end

  describe "#deposit" do
    before { account.deposit(deposit_amount) }
    it "increases the account balance by the specified amount" do
      expect(account.balance).to eq deposit_amount
    end
    it "must be a positive number" do
      expect{ account.deposit(-deposit_amount) }.to raise_error negative_deposit_error
    end
  end

  describe "#withdraw" do
    before do
      account.deposit(deposit_amount)
      account.withdraw(withdraw_amount)
    end
    it "decreases the account balance by the specified amount" do
      expect(account.balance).to eq deposit_amount - withdraw_amount
    end
    it "doesn't allow withdrawal in excess of balance" do
      expect{ account.withdraw(account.balance + 1) }.to raise_error insufficient_funds_error
    end
    it "must be a positive number" do
      expect{ account.withdraw(-withdraw_amount) }.to raise_error negative_withdrawal_error
    end
  end
end
