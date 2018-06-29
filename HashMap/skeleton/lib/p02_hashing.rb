class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    output = self.join.bytes.join.to_i
    output.round(1000000)
  end
end

class String
  def hash
    output = self.bytes.join.to_i
    output.round(1000000)
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    output = self.keys.join.bytes.sort.join.to_i
    output.round(1000000)
  end
end
