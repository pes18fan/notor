require "json"
require "./notes"

unless File.exists?(Globals.notes_file)
  json_file = File.new(Globals.notes_file, "w")
  json_file.close
end

def write_note(note : Note)
  Globals.notes_array << note.note_data
  notes_to_json
end

def notes_to_json
  notes_json_string = JSON.build do |json|
    json.object do
      Globals.notes_array.tap &.each do |i|
        i.tap &.each do |title, content|
          json.field title, content
        end
      end
    end
  end

  json_file = File.open(Globals.notes_file, "w")
  json_file.puts "{#{notes_json_string}}"
  json_file.close
end