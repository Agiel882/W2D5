require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.include?(key)
      update_node!(@map[key])
    else
      calc!(key)
    end
    return @map[key].val
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private

  # suggested helper method; insert an (un-cached) key
  def calc!(key)
    new_node = @store.append(key, @prc.call(key))
    @map[key] = new_node
    if count > @max
      eject!
    end
  end

  def update_node!(node)
    @store.remove(node.key)
    new_node = @store.append(node.key)
    @map[node.key] = new_node
    # suggested helper method; move a node to the end of the list
  end

  def eject!
    node = @store.first
    @store.remove(node.key)
    @map.delete(node.key)
  end
end
