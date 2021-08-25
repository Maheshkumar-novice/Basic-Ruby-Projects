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

def swap(index1, index2, values)
  values[index1], values[index2] = values[index2], values[index1]
end

def print_sorted(comparisons, swaps, values, type, given)
  puts '======================================'.cyan
  puts type
  puts "Given List: #{given}".cyan
  puts "Sorted List: #{values}".green
  puts "No Of Comparisons Performed: #{comparisons}".red
  puts "No Of Swaps Performed: #{swaps}".yellow
  puts '======================================'.cyan
end

# Bubble Sort General Approach
def bubble_sort_general(values)
  type = 'Bubble Sort - General:'.cyan
  puts type
  given = values
  puts "Given List: #{values}\n\n".cyan
  no_of_comparisons = 0
  no_of_swaps = 0
  swapped = true
  while swapped
    swapped = false
    (1..values.size - 1).each do |j|
      no_of_comparisons += 1
      puts "Comparison: #{values[j]} #{values[j - 1]}".red
      if values[j] < values[j - 1]
        puts "Swap: #{values[j]} #{values[j - 1]}".green
        swap(j, j - 1, values)
        swapped = true
        no_of_swaps += 1
      end
      puts "Current State: #{values}\n\n".yellow
    end
  end
  [no_of_comparisons, no_of_swaps, values, type, given]
end

# Bubble Sort With Optimization
def bubble_sort_optimize(values)
  type = 'Bubble Sort - Optimized:'.cyan
  puts type
  given = values
  puts "Given List: #{values}\n\n".cyan
  no_of_comparisons = 0
  no_of_swaps = 0
  swapped = true
  length = values.size
  while swapped
    swapped = false
    (1..length - 1).each do |j|
      no_of_comparisons += 1
      puts "Comparison: #{values[j]} #{values[j - 1]}".red
      if values[j] < values[j - 1]
        puts "Swap: #{values[j]} #{values[j - 1]}".green
        swap(j, j - 1, values)
        swapped = true
        no_of_swaps += 1
      end
      puts "Current State: #{values}\n\n".yellow
    end
    length -= 1
  end
  [no_of_comparisons, no_of_swaps, values, type, given]
end

# Bubble Sort With More Optimization
def bubble_sort_more_optimize(values)
  type = 'Bubble Sort - More Optimized:'.cyan
  puts type
  given = values
  puts "Given List: #{values}\n\n".cyan
  no_of_comparisons = 0
  no_of_swaps = 0
  length = values.size
  while length > 1
    new_last = 0
    (1..length - 1).each do |j|
      no_of_comparisons += 1
      puts "Comparison: #{values[j]} #{values[j - 1]}".red
      if values[j] < values[j - 1]
        puts "Swap: #{values[j]} #{values[j - 1]}".green
        swap(j, j - 1, values)
        no_of_swaps += 1
        new_last = j
      end
      puts "Current State: #{values}\n\n".yellow
    end
    length = new_last
  end
  [no_of_comparisons, no_of_swaps, values, type, given]
end

# Init
puts "\nBubble Sort\n\n".green
# Input Part
puts '1) For Space Separated Values'.cyan
puts '2) For Entering Values One by One'.cyan
print '> '.cyan
choice = gets.chomp.to_i
if (choice != 1) && (choice != 2)
  puts 'Enter a Valid Value!'.red
  exit

elsif choice == 1
  values = []
  print "\nEnter the Space Separated Value > ".yellow
  input = gets.chomp
  input.split(' ').map do |value|
    values << value.to_i if (value.count('0-9') != 0) && value.count('a-z').zero?
  end
  puts 'Valid Values from the Given input > '.cyan + values.to_s.green
  if values.size.zero? || (values.size == 1)
    puts 'No of Values should be more than 1'.red
    exit
  end
elsif choice == 2
  print "\nHow many Values do you have > ".yellow
  no_of_values = gets.chomp.to_i
  if no_of_values.zero? || (no_of_values == 1)
    print 'No Zero or One!'.red
    exit
  end

  values = []
  puts 'Enter Values One by One'.yellow
  no_of_values.times do
    print '> '.cyan
    value = gets.chomp.downcase
    if (value.count('0-9') != 0) && value.count('a-z').zero?
      values << value.to_i
    else
      redo
    end
  end
  puts 'Values > '.yellow + values.inspect.green
end

# Method Call & Printing Results
result1 = bubble_sort_general(values.dup)
result2 = bubble_sort_optimize(values.dup)
result3 = bubble_sort_more_optimize(values.dup)
print_sorted(*result1)
print_sorted(*result2)
print_sorted(*result3)
