class Note
  @@number_of_notes = 0
  
  property note_data = {} of String => String

  def self.number_of_notes
    @@number_of_notes
  end

  def self.note
    @note_data
  end

  def initialize(title : String, content : String)
    @title = title
    @content = content

    @note_data[title] = content

    @@number_of_notes += 1
  end
end