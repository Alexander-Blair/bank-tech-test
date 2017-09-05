## RESULT: MORE WORK TO DO

Good 1st draft. Passes Acceptance Criteria, and then more.

But where did the extra stuff come from? I feel like you've made some more up? 100% stick to the user stories, and focus on test driving this implementation. You could do the snazziest tech test and get rejected out of hand regardless.

- (I am saying this to everyone) Seriously, please read all of this: https://github.com/makersacademy/jobhunters/blob/master/pills/tech_test_guide.md

### LIB
- NICE: the direction to go down in terms of types of transactions. How could you use the Factory Pattern to reduce the arguments in the new method?
Essentially something like `Transaction.debit(amount: 50, balance: 1000 )`
- what are the responsibilities of Account? Can this be broken down?
- think harder about single responsibilities. Each method, each class.
- Think about raising your own custom errors. Then you can assert on error types not strings.
- transaction_builder is oddly named. it's meant to be the class?
- at the moment the deposit and withdraw methods are exactly the same bar 5 words.
- The statement printer needs to be simplified.
  - .each_with_object([]) is just map
  - is there a reason print_transaction is public?

### SPECS
- remove comments from spec_helper and  SimpleCov
- use subject specifically in your context blocks, if you need to change it. This is weird:
```ruby
subject(:transaction) { described_class.new(amount, :credit, balance) }
let(:debit_transaction) { described_class.new(amount, :debit, balance) }

```
- account spec has a lot of let blocks in the top most describe block. Can you be more specific? Maybe they need only be in a certain context block. This would help a reader understand the scope better.
- do end blocks for multiline

### README.md
- NICE: Good info about approach.
- Think of the order set up. I want to run bundle after I clone and cd into your project. a
- what are the return values meant to be when i use it in irb?
- you can format better using backticks

### STYLE
- NICE: code looks easy to read
- NICE: COVERAGE: 100.00% -- 162/162 lines in 6 files

### OTHER
- If you launch IRB from bank.rb, why not also load the instance of Account?
