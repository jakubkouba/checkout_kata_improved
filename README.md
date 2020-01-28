## Checkout Kata
### Amount discount exercise

[Description from codekata.com](http://codekata.com/kata/kata09-back-to-the-checkout)

Having set of discount rules, when scanning items, discount rules should be applied to final price

With following discount rules

| Item | Unit Price | Special Price |
|:-----|:-----------|:--------------|
|   A  |   50       | 3 for 130     |
|   B  |   30       | 2 for 45      |
|   C  |   20       |               |
|   D  |   15       |               |
    
When basket contains ABAAD the price should be 175

#### Usage

``$ git clone git@github.com:jakubkouba/checkout_kata.git``

``$ cd back_to_the_checkout``

``$ bundle``

``$ rspec``
