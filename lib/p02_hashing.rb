class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
     accum = 0
     self.each_with_index do |el, idx|
      if el.is_a?(Integer)
        accum ^= (el + idx)
      else
        accum ^= el.hash
      end
     end
     accum
  end
end

class String
  def hash
    self.chars.map{ |el| el.ord}.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    self.to_a.sort.hash
  end
end
