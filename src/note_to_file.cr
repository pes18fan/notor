require "json"
require "./notes"

# Block to check if the json file storing the notes exists, and create it if it does not.
unless File.exists?(Globals.notes_file)
  json_file = File.new(Globals.notes_file, "w")
  json_file.close
end

# Function to push the note passed to the app to the global notes array.
def write_note(note : Note)
  Globals.notes_array << note.note_data
  notes_to_json
end

# Function to write notes to a json file.
def notes_to_json
  notes_json_string = JSON.build do |json|
    json.object do
      json.field "note_number", "#"
      json.field "notes" do
        json.array do
          Globals.notes_array.tap &.each do |i|
            i.tap &.each do |title, content|
              json.field title, content
            end
          end
        end
      end
    end
  end

  json_file = File.open(Globals.notes_file, "w")
  json_file.puts "{#{notes_json_string}}"
  json_file.close
end
