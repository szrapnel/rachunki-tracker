class TitleGenerator

  def self.get_next_title(old_title)
    return nil if old_title.nil?
    source = ['I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX', 'X', 'XI', 'XII']
    destination = ['II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX', 'X', 'XI', 'XII', 'I']
    return destination[source.index(old_title)] if source.include?(old_title)
    return old_title
  end
  
end
