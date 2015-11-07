class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil, nxt = nil, prev = nil)
    @key, @val, @next, @prev = key, val, nxt, prev
  end

  def to_s
    "#{@key}, #{@val}"
  end
end

class LinkedList
  include Enumerable

  attr_reader :head, :tail

  def initialize
    @head = nil
    @tail = nil
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head
  end

  def last
    @tail
  end

  def empty?
  end

  def get(key)
    find(key).val if find(key)
  end

  def find(key)
    if @head
      if @head.key == key
        return @head
      else next_link = @head.next
        until next_link.nil?
          return next_link if next_link.key == key
          next_link = next_link.next
        end
      end
    end
    nil

  end

  def include?(key)
    find(key) ? true : false
  end

  def insert(key, val)
    if @head.nil?
      @head = Link.new(key, val)
      @tail = @head
    else @tail.next = Link.new(key, val, nil, @tail)
      @tail = @tail.next
    end
  end

  def remove(key)
    if find(key)
      link = find(key)
      if link == @head
        @head = link.next
        @head.prev = nil
        return
      elsif link == @tail
        @tail = link.prev
        @tail.next = nil
        return
      end
      link.next.prev = link.prev
      link.prev.next = link.next
    end
  end

  def each(&block)
    return nil if @head.key.nil?
    block.call(@head)
    next_link = @head.next
    until next_link.nil?
      block.call(next_link)
      next_link = next_link.next
    end
  end

  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end

end
