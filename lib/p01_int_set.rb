class MaxIntSet
  def initialize(max)
    @store = Array.new(max, false)
  end

  def insert(num)
    raise 'Out of bounds' if num < 0 or num > @store.length
    @store[num] = true
  end

  def remove(num)
    raise 'Out of bounds' if num < 0 or num > @store.length
    @store[num] = false
  end

  def include?(num)
    raise 'Out of bounds' if num < 0 or num > @store.length
    @store[num]
  end

  private

  def is_valid?(num)
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num unless include?(num)
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    unless include?(num)
      self[num] << num
      @count += 1
    end
    if count > num_buckets
      resize!
    end
  end

  def remove(num)
    success = self[num].delete(num)
    @count -= 1 if success
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    @store[num % @store.length]
  end

  def num_buckets
    @store.length
  end

  def resize!
    num_buckets.times do
      @store << []
    end
    @store.each_with_index do |bucket, i|
      bucket.each do |el|
        next if el % num_buckets == i
        bucket.delete(el)
        self[el] << el
      end
    end
  end
end
