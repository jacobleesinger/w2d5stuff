class MaxIntSet
  def initialize(max)
    @store = Array.new(max, false)
  end

  def insert(num)
    validate!(num)
    @store[num-1] = true
  end

  def remove(num)
    validate!(num)
    @store[num-1] = false
  end

  def include?(num)
    validate!(num)
    @store[num-1]
  end

  private

  def is_valid?(num)

    num.between?(0, @store.length)
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    @store[num % 20] << num unless @store[num % 20].include?(num)
  end

  def remove(num)
    @store[num % 20].delete(num)
  end

  def include?(num)
    @store[num % 20].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @num_buckets = num_buckets
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    @store[num % num_buckets] << num unless @store[num % num_buckets].include?(num)
    @count += 1
    if @count > num_buckets
      resize!
    end
  end

  def remove(num)
    @store[num % num_buckets].delete(num)
    @count -= 1
  end

  def include?(num)
    @store[num % num_buckets].include?(num)
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
