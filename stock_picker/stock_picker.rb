#!/usr/bin/env ruby
# frozen_string_literal: true

require 'rubygems'
begin
  gem 'colorize'
rescue Gem::LoadError
#   Gem.install('colorize')
 `gem install colorize --user`
  gem 'colorize'
end
require 'colorize'

# Sample Input: [17,3,6,9,15,8,6,1,10], Sample Output: 12, 1, 4
# Stock Picker Method
def stock_picker(prices)
  # To store previous profit value
  previous_value = -1_000_000_000
  price_combination_range = (0..prices.size - 1).to_a
  # To generate all 2 element combinations with indexes
  price_combinations_pairs = price_combination_range.combination(2).to_a
  # Reducing Combinations of indexes into profit-days combo
  price_combinations_pairs.each_with_object([]) do |pair, profit_data|
    profit_value = prices[pair[1]] - prices[pair[0]]
    next unless profit_value > previous_value

    profit_data.clear
    profit_data.push(profit_value, pair[0], pair[1])
    previous_value = profit_value
  end
end

# Init
puts "\nThis Program gives you the best possible outcome\n\n".green
# Input Part
puts '1) For Space Separated Values'.cyan
puts '2) For Entering Values One by One'.cyan
print '> '.cyan
choice = gets.chomp.to_i
if (choice != 1) && (choice != 2)
  puts 'Enter a Valid Value!'.red
  exit

elsif choice == 1
  prices = []
  print "\nEnter the Space Separated Prices > ".yellow
  input = gets.chomp
  input.split(' ').map do |price|
    prices << price.to_i if (price.count('0-9') != 0) && price.count('a-z').zero?
  end
  puts 'Valid Prices from the Given input > '.cyan + prices.to_s.green
  if prices.size.zero? || (prices.size == 1)
    puts 'No of Values should be more than 1'.red
    exit
  end
elsif choice == 2
  # Get the No Of Days
  print "\nHow many days of data do you have > ".yellow
  no_of_days = gets.chomp.to_i
  # condition if not a number given
  if no_of_days.zero? || (no_of_days == 1)
    print 'No Zero or One!'.red
    exit
  end

  # Get Prices one by one
  prices = []
  puts 'Enter Prices One by One'.yellow
  no_of_days.times do
    print '> '.cyan
    price = gets.chomp.downcase
    # condition to check for only numbers
    if (price.count('0-9') != 0) && price.count('a-z').zero?
      prices << price.to_i
    else
      redo
    end
  end
  puts 'Prices > '.yellow + prices.inspect.green
end

# Method Call & Printing Results
data = stock_picker(prices)
buying_day = "Day #{data[1] + 1}".cyan
selling_day = "Day #{data[2] + 1}".cyan
profit = if (data[0]).positive?
           "$ #{data[0]}".green
         else
           "$ #{data[0]}".red
         end
print "#{"\nIf you buy on ".yellow}#{buying_day}#{' and sell on '.yellow}#{selling_day}#{', You will get profit of '.yellow}#{profit}\n"
