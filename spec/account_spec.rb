require 'account'

describe Account do
  let(:deposit_amount) { 100 }
  let(:withdraw_amount) { 25 }
  let(:float_number) { 7.5 }
  let(:current_balance) { account.balance }
  let(:insufficient_funds_error) { 'Insufficient funds' }
  let(:negative_deposit_error) { 'Cannot deposit negative amount' }
  let(:non_integer_deposit_error) { 'Cannot deposit decimal amount' }
  let(:non_integer_withdraw_error) { 'Cannot withdraw decimal amount' }
  let(:negative_withdrawal_error) { 'Cannot withdraw negative amount' }
  let(:transaction_builder) { class_double('Transaction') }
  let(:statement_printer) { instance_double('statement_printer', :print_statement) }
  subject(:account) { described_class.new(transaction_builder, statement_printer) }

  before do
    allow(transaction_builder).to receive(:new)
  end

  describe '#initialize' do
    it 'begins with a balance of 0' do
      expect(account.balance).to eq 0
    end
    it 'has an empty transactions array' do
      expect(account.transactions).to be_empty
    end
  end

  describe '#deposit' do
    context 'valid deposit' do
      it 'increases the account balance by the specified amount' do
        account.deposit(deposit_amount)
        expect(account.balance).to eq deposit_amount
      end
      it 'asks transactions class to create a new transaction' do
        expect(transaction_builder)
          .to receive(:new)
          .with(deposit_amount, :credit, current_balance + deposit_amount)
        account.deposit(deposit_amount)
      end
      it 'stores the transaction in its transaction array' do
        expect { account.deposit(deposit_amount) }
          .to change { account.transactions.length }.by(1)
      end
    end
    context 'invalid deposit' do
      it 'must be a positive number' do
        expect { account.deposit(-deposit_amount) }
          .to raise_error negative_deposit_error
      end
      it 'must be an integer' do
        expect { account.deposit(float_number) }
          .to raise_error non_integer_deposit_error
      end
    end
  end

  describe '#withdraw' do
    before { account.deposit(deposit_amount) }
    context 'valid withdrawal' do
      it 'decreases the account balance by the specified amount' do
        account.withdraw(withdraw_amount)
        expect(account.balance).to eq deposit_amount - withdraw_amount
      end
      it 'asks transactions class to create a new transaction' do
        expect(transaction_builder)
          .to receive(:new)
          .with(withdraw_amount, :debit, current_balance - withdraw_amount)
        account.withdraw(withdraw_amount)
      end
      it 'stores the transaction in its transaction array' do
        expect { account.withdraw(withdraw_amount) }
          .to change { account.transactions.length }.by(1)
      end
    end
    context 'invalid withdrawal' do
      it 'does not allow withdrawal in excess of balance' do
        expect { account.withdraw(account.balance + 1) }
          .to raise_error insufficient_funds_error
      end
      it 'must be a positive number' do
        expect { account.withdraw(-withdraw_amount) }
          .to raise_error negative_withdrawal_error
      end
      it 'must be an integer' do
        expect { account.withdraw(float_number) }
          .to raise_error non_integer_withdraw_error
      end
    end
  end
  describe '#view_statement' do
    it 'asks the statement printer to print the account statement' do
      expect(statement_printer)
        .to receive(:print_statement)
        .with(account.transactions)
      account.view_statement
    end
  end
end
