class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    our_hash = 0
    our_hash = 6197253728 if empty?
    each_with_index do |el, idx|
      our_hash += idx.hash * el.hash
    end
    our_hash
  end
end

class String
  def hash
    letters = self.split("")
    our_hash = 0
    letters.each_with_index do |letter, idx|
      our_hash += letter.ord.hash / idx.hash
    end
    our_hash
  end
end

class Hash
  def hash
    our_hash = 0
    self.each do |key, value|
      # key = "nil" if key.nil?
      # value = "nil" if value.nil?
      our_hash += key.hash * value.hash
    end
    our_hash

  end
end
