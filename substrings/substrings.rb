#!/usr/bin/env ruby
# frozen_string_literal: true

require 'awesome_print'
require 'clipboard'

dictionary = %w[below down go going horn how howdy it i low own part partner sit]

# Method to count the substrings
def count_substrings(dictionary, string)
  dictionary.each_with_object(Hash.new(0)) do |word, substring_count|
    substring_count[word] = string.scan(word).count if string.include?(word)
  end
end

loop do
  print "\nDo you want to use your clipboard text? (y/n) > ".yellow
  choice = gets.chomp

  # Text Choice Selection
  if choice == 'y'
    string = Clipboard.paste.downcase
    print 'Text from Clipboard > '.yellow
    print "#{string}\n".cyan
  else
    print 'Enter the String (Enter to quit) > '.yellow
    string = gets
    break if string == "\n"

    string = string.chomp.downcase
  end

  # Count String => Print the Result with Awesome Print => Copy the return value to Clipboard
  Clipboard.copy((ap count_substrings(dictionary, string), color: { hash: :green }).to_s)
  puts 'Answer Pasted To Clipboard!'.red
end
