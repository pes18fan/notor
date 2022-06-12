require "json"
require "./notes"

# This file manages the pulling and pushing of notes data from and to a json file that stores the notes.
# TODO: Add a feature to delete notes

# Function to write notes to a json file.
def notes_to_json
  notes_json_string = JSON.build do |json|
    json.object do
      json.field "note_number", Globals.notes_array.size
      json.field "notes" do
        json.array do
          Globals.notes_array.tap &.each do |i|
            i.tap &.each do |title, content|
              json.object do
                json.field title, content
              end
            end
          end
        end
      end
    end
  end

  json_file = File.open(Globals.notes_file, "w")
  json_file.puts notes_json_string
  json_file.close
end

# Function to pull notes from the json file if they are already present.
def pull_notes
  # Block to check if the folder holding notor's data exists. If installed using make, this directory is made automatically.
  unless Dir.exists?(Globals.files_dir)
    Dir.mkdir(Globals.files_dir)
  end

  # Block to check if the json file storing the notes exists, and create it in proper format if it does not.
  unless File.exists?(Globals.notes_file)
    initialization_string = JSON.build do |json|
      json.object do
        json.field "note_number", Globals.notes_array.size
        json.field "notes" do
          json.array do
          end
        end
      end
    end

    json_file = File.new(Globals.notes_file, "w")
    json_file.puts initialization_string
    json_file.close
  end

  notes_json = File.open(Globals.notes_file) do |file|
    JSON.parse(file)
  end

  notes = Array(Hash(String, String)).from_json(notes_json["notes"].to_json)

  notes.tap &.each do |note|
    Globals.notes_array << note
  end
end

# Function to push the note passed to the app to the global notes array.
def write_note(note : Note)
  Globals.notes_array << note.note_data

  notes_to_json
end

# Function to delete all notes.
def reset_notes
  Globals.notes_array.clear

  reset_string = JSON.build do |json|
    json.object do
      json.field "note_number", Globals.notes_array.size
      json.field "notes" do
        json.array do
        end
      end
    end
  end

  json_file = File.open(Globals.notes_file, "w")
  json_file.puts reset_string
  json_file.close
end
