require "time"

class Note
  property title : String
  property content : String
  property created_on : String
  property note_data : Hash(String, String)

  def initialize(title : String, content : String, created_on : Time)
    @title = title
    @content = content
    @created_on = created_on.to_s("%Y/%m/%d %r %a")

    @note_data = {
      "title"      => @title,
      "content"    => @content,
      "created_on" => @created_on,
    }
  end
end
