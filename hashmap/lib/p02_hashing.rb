class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    return 345871348095 if self.empty?
    primes = [11, 13, 17]
    self.map.with_index do |el, i|
      j = i % 3
      (el * primes[j]).hash
    end.inject(:^)
  end
end

class String
  def hash
    self.split('').map do |letter|
      letter.ord
    end.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    self.keys.sort.map do |key|
      key.to_s.hash
    end.hash
  end
end
