# Class that defines the notes.
class Note
  property note_data = {} of String => String

  def self.note_data
    @note_data
  end

  def initialize(title : String, content : String)
    @title = title
    @content = content

    @note_data[title] = content
  end
end
