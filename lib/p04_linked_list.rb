class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    @prev.next = @next
    @next.prev = prev
    prev, @next = nil
  end
end

class LinkedList
  include Enumerable
  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    first == @tail
  end

  def get(key)
    node = get_node(key)
    node ? node.val : nil
  end

  def include?(key)
    !!get(key)
  end

  def append(key, val = nil)
    new_node = Node.new(key, val)
    prev_node = @tail.prev
    @tail.prev = new_node
    prev_node.next = new_node
    new_node.prev = prev_node
    new_node.next = @tail
    new_node
  end

  def update(key, val)
    node = get_node(key)
    node.val = val if node
  end

  def remove(key)
    node = get_node(key)
    node.remove if node
    node
  end

  def each
    current = @head.next
    until current == @tail || !current
      yield current
      current = current.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end

  private
  def get_node(key)
    current = @head
    until current == @tail
      return current if current.key == key
      current = current.next
    end
    nil
  end
end
