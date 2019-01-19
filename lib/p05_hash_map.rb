require_relative 'p04_linked_list'
require "byebug"

class HashMap
  include Enumerable
  attr_accessor :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    if include?(key)
      bucket(key).update(key, val)
    else
      bucket(key).append(key, val)
      @count += 1
    end
    resize! if count > num_buckets
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    success = bucket(key).remove(key)
    @count -= 1 if success
  end

  def each
    @store.each do |bucket|
      bucket.each do |el|
        yield(el.key, el.val)
      end
    end
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    num_buckets.times{ @store << LinkedList.new }
    @store.each_with_index do |bucket, i|
      bucket.each do |el|
        next if bucket(el.key) == i
        bucket.remove(el.key)
        bucket(el.key).append(el.key, el.val)
      end
    end
  end

  def bucket(key)
    @store[key.hash % num_buckets]
  end
end
