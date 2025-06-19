# Monkey patch for String class to add a titleize method

class String
  def titleize
    split(' ').collect { |word| word.capitalize }.join(' ')
  end
end
