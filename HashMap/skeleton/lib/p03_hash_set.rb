require_relative "p02_hashing"

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    unless  include?(key)
      resize! if count == num_buckets
      self[hash(key)].push(key)
      @count += 1
    end
  end

  def include?(key)
    self[hash(key)].any? {|el| el == key}
  end

  def remove(key)
    if include?(key)
      self[hash(key)].delete(key)
      @count -= 1
    end
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store
    @store = Array.new(num_buckets * 2) { [] }
    old_store.each do |bucket|
      bucket.each {|el| self[el].push(el)}
    end
  end

  def hash(el)
    el.hash
  end
end
