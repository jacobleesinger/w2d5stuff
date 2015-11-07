require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    num = key.hash
    unless @store[num % num_buckets].include?(num)
      @store[num % num_buckets] << num
    end
    @count += 1
    if @count > num_buckets
      resize!
    end
  end

  def include?(key)
    num = key.hash
    @store[num % num_buckets].include?(num)
  end

  def remove(key)
    num = key.hash
    @store[num % num_buckets].delete(num)
    @count -= 1
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    @count = 0
    new_length = 2 * num_buckets
    old_store = @store
    @store = Array.new(new_length) { Array.new }
    old_store.flatten.each do |el|
      insert(el)
    end
  end
end
