class StaticArray
  attr_reader :store

  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    self.store[i]
  end

  def []=(i, val)
    validate!(i)
    self.store[i] = val
  end

  def length
    self.store.length
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, self.store.length - 1)
  end
end

class DynamicArray
  attr_accessor :count

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
  end

  def [](i)
    return nil if i > capacity
    return @store[i]
  end

  def []=(i, val)
    while i > capacity
      resize!
    end
    @count += 1 unless @store[i]
    @store[i] = val
  end

  def capacity
    @store.length
  end

  def include?(val)
    i = 0
    while i < capacity
      return true if self[i] == val
      i += 1
    end
    false
  end

  def push(val)
    i = capacity - 1
    while @store[i] == nil && i > 0
      i -= 1
    end
    if @store[i]
      @store[i + 1] = val
    else
      @store[i] = val
    end
  end

  def unshift(val)
  end

  def pop
  end

  def shift
  end

  def first
  end

  def last
  end

  def each
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    # ...
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
    new_store = StaticArray.new(capacity * 2)
    i = 0
    while i < capacity
      new_store[i] = @store[i]
      i += 1
    end
  end
end
