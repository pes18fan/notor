require "./globals"

class Note
  property title : String
  property content : String
  property created_on : Time
  property created_on_unix_stamp : Int32
  property note_data : Hash(String, (String | Int32))

  def initialize(title : String, content : String, created_on : Time)
    @title = title
    @content = content
    @created_on = created_on
    @created_on_unix_stamp = Globals.unix_stamp(created_on)

    @note_data = {
      "title" => @title,
      "content" => @content,
      "created_on" => @created_on_unix_stamp
    }
  end
end