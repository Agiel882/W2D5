class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
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
    @store[num.hash % num_buckets]
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
        next if el.hash % num_buckets == i
        bucket.delete(el)
        self[el] << el
      end
    end
  end
end
