# Bank Tech Test

### How to run

This is a command line application, which can be run by doing the following:

$ git clone git@github.com:Alexander-Blair/bank-tech-test.git  
$ cd bank-tech-test  
$ ruby bank.rb  

\> account = Account.new(Transaction, StatementPrinter.new)  

Then you can deposit and withdraw with the following commands:

\> account.deposit(1000)  
\> account.withdraw(500)  

You can view your statement with the following command:

\> account.view_statement  

### Running the tests

$ gem install bundler  
$ bundle install  
$ rspec

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
