require 'account'

describe Account do
  subject(:account) { described_class.new }
  let(:deposit_amount) { 100 }

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
  end
end
