# Class that defines the notes.
class Note
  # A hash defining the actual data of the note.
  # Includes a single key-value pair where the key is the title of the note instance and the value is the content.
  property note_data = {} of String => String

  def initialize(title : String, content : String)
    @title = title
    @content = content

    @note_data[title] = content
  end
end
