require 'pry-byebug'
require 'rubocop'

module Enumerable
  def my_each_with_index
    mirror = []
    length.times do |i|
      mirror << self[i] if yield(self[i], i).nil?
    end
    mirror
  end

  def my_select
    results = []
    each do |elem|
      results << elem if yield(elem)
    end
    results
  end

  def my_all?
    pass = true
    each do |elem|
      unless yield(elem)
        pass = false
        break
      end
    end
    pass
  end

  def my_none?
    pass = true
    each do |elem|
      if yield(elem)
        pass = false
        break
      end
    end
    pass
  end

  def my_any?
    pass = false
    each do |elem|
      if yield(elem)
        pass = true
        break
      end
    end
    pass
  end

  def my_count
    return length unless block_given?

    count = 0
    each do |elem|
      count += 1 if yield(elem)
    end
    count
  end

  def my_map
    result = []
    each do |elem|
      result << yield(elem)
    end
    result
  end

  def my_inject(initial_value)
    result = initial_value
    each do |elem|
      result = yield(result, elem)
    end
    result
  end
end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  def my_find
    each do |elem|
      return elem if yield(elem)
    end

    nil
  end

  def my_each
    for element in self
      yield(element)
    end
  end

  def my_map
    result = []
    each do |elem|
      result << yield(elem)
    end
    result
  end
end
