require_relative 'p05_hash_map'
require_relative 'p04_linked_list'
require 'byebug'

class LRUCache
  attr_reader :count
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
    # debugger
    if @map.include?(key)

      value = @map.get(key)
      update_link!(@store.find(key))
      return value
    else calc!(key)
    end
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # debugger
    val = @prc.call(key)
    @store.insert(key, val)
    @map.set(key, val)
    eject! if self.count > @max
  end

  def update_link!(link)
    if link == @store.first
      if link != @store.last
        @store.first = link.next
        @store.first.prev = nil
        link.prev = @store.last
        @store.last = link
      end

      return
    end
    return if link == @store.last

    link.next.prev = link.prev
    link.prev.next = link.next
    # suggested helper method; move a link to the end of the list
  end

  def eject!
    key = @store.first.key
    @store.remove(key)
    @map.delete(key)
  end
end

lru = LRUCache.new(3, Proc.new{ |x| x **2 })
lru.get(5)
lru.get(6)

# 1.upto(4) { |i| lru.get(i) }
# lru.get(3)
# puts lru
