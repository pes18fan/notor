require "json"
require "./notes"

def write_note(note : Note)
  json_note = note.note_data.to_json
end

def write_note_file(note : Note)
  notes_json_string = JSON.build do |json|
    json.object do
    end
  end
end