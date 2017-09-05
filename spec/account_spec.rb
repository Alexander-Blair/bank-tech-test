require 'account'

describe Account do
  let(:current_balance) { account.balance }
  let(:non_integer_error) { 'Cannot be decimal amount' }
  let(:transaction_history) do
    instance_double('TransactionHistory', credit: nil, debit: nil, transactions: nil)
  end
  let(:statement_printer) { instance_double('statement_printer') }

  subject(:account) { described_class.new(transaction_history, statement_printer) }

  describe '#initialize' do
    it 'begins with a balance of 0' do
      expect(account.balance).to eq 0
    end
  end

  describe '#deposit' do
    let(:deposit_amount) { 100 }

    context 'valid deposit' do
      it 'increases the account balance by the specified amount' do
        account.deposit(deposit_amount)
        expect(account.balance).to eq deposit_amount
      end

      it 'asks transaction history object to store transaction' do
        expect(transaction_history)
          .to receive(:credit)
          .with(deposit_amount, current_balance + deposit_amount)
        account.deposit(deposit_amount)
      end
    end

    context 'invalid deposit' do
      let(:float_number) { 7.5 }

      it 'must be an integer' do
        expect { account.deposit(float_number) }
          .to raise_error non_integer_error
      end
    end
  end

  describe '#withdraw' do
    let(:deposit_amount) { 100 }
    let(:withdraw_amount) { 25 }

    before { account.deposit(deposit_amount) }

    context 'valid withdrawal' do
      it 'decreases the account balance by the specified amount' do
        account.withdraw(withdraw_amount)
        expect(account.balance).to eq deposit_amount - withdraw_amount
      end

      it 'asks transactions class to create a new transaction' do
        expect(transaction_history)
          .to receive(:debit)
          .with(withdraw_amount, current_balance - withdraw_amount)
        account.withdraw(withdraw_amount)
      end
    end

    context 'invalid withdrawal' do
      let(:float_number) { 7.5 }

      it 'must be an integer' do
        expect { account.withdraw(float_number) }
          .to raise_error non_integer_error
      end
    end
  end

  describe '#view_statement' do
    it 'asks the statement printer to print the account statement' do
      expect(statement_printer).to receive(:print_statement)
      account.view_statement
    end
  end
end
