# Bank Tech Test

### How to run

This is a command line application, which can be run by doing the following:

```sh
$ git clone git@github.com:Alexander-Blair/bank-tech-test.git  
$ cd bank-tech-test  
$ gem install bundler  
$ bundle install  
$ ruby bank.rb  
```

```ruby
> transaction_history = TransactionHistory.new(Transaction)
> statement_printer = StatementPrinter.new(StatementLine.new)
> account = Account.new(transaction_history, statement_printer)

# Then you can deposit and withdraw with the following commands:

> account.deposit(1000)  
> account.withdraw(500)  

# You can view your statement with the following command:

> account.view_statement
```

### Running the tests
Running RSpec will show the test coverage through SimpleCov.

```sh
$ rspec  
```

You can also run the following command to see rubocop results:  
```sh
$ rubocop
```
### Approach

The application has been developed in a TDD style, having 100% test coverage, with all passing. There are three classes, only one with which the user will interact with - Account.

The account class has two dependencies (Transaction, StatementPrinter), which are injected upon initialization, in order to make the code easy to test and change.

The Account class has three public methods - deposit, withdraw, and view statement. The deposit and withdraw methods change the account balance; note that the account works with PENNIES (or cents, depending where you are).

In order to view the statement, and allow the Account to have single responsibility, two additional classes were added - Transaction, which keeps track of details for a completed transaction, and StatementPrinter, which takes all the transactions and prints them out, with the latest transaction first.

### User Stories
```
As a user,
So that I can keep my money safe,  
I want to make a deposit at the bank.
```

```
As a user,  
So that I can spend my money,
I want to make a withdrawal from the bank.
```

```
As a user,  
So I can keep track of my spending,  
I want to be able to print a statement of my transactions.
```

```
As a user,  
So that I can see relevant information,
I want the statement to show my latest transactions first.
```
