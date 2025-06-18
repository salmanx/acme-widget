class String
  def titleize
    split(' ').collect { |word| word.capitalize }.join(' ')
  end
end
