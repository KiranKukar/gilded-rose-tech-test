# guilded-rose-tech-test #
===========================

## My approach ##
I first added the legacy code for the test to a file.
Set up rspec, simplecov and rubo cop - for code quality.
Before refacoring the update_quality method in the GildedRose class I set up tests to cover all the current requirments that are being met.
This way I can ensure that when refactoring they all continue to be met.
I've refactored the update_quality method in the GildedRose class with all tests still passing so now it is ready to add the new requirments.
I've added in the Conjured items requirments using TDD

# How I structured the code and why
- After refactoring the update_quality method and adding the conured option, the method was long and unclear to read.
- So I created a single method to calculate the sell_in change for all items.
- I also created a mthod to calcullate item_quality but that was also very long, so now the method calls a method for each of the items' quality to be calculated.

# How to run the code
- clone the repo to your machine
- run bundle install
- start irb by running 'irb' in the terminal
- set up by running these commands in irb:
  * require './lib/guilded_rose.rb'
- for each item you want to create run:
  * item = Item.new("Item Name",sell_in(e.g.20),quality(e.g.20))
- to set up the GildedRose, create a new instance of the class with all yor items:
  * gilded_rose = GildedRose.new([item1, item2, item3, item4, item5])
- to update their quality at the end of the day run:
  * gilded_rose.update_quality

# How to run the tests
 - make sure you have rspec installed
 - and you're in the 'gilded-rose-tech-test- directory
 - run 'rspec' in the terminal