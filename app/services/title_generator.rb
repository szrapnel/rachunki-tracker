class TitleGenerator

  def self.get_next_title(old_title)
    source = ['I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX', 'X', 'XI', 'XII']
    destination = ['II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX', 'X', 'XI', 'XII', 'I']
    return destination[source.index(old_title)] unless old_title.nil?
  end
  
end
