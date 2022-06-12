require "json"
require "./notes"

# This file defines functions for various actions done on the notes, like adding new ones or deleting existing ones.

# Function to write all notes in the global notes array to a json file.
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

# Function to pull notes from the json file if they are already present, and add them into the global notes array.
# Executed at the beginning of the program execution
def pull_notes
  # Block to check if the folder holding notor's data exists.
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

# Function to print the specified note to stdout.
# Returns 0 if note was successfully printed out, 1 on failure.
def cat(title : String) : Int32
  count = 0

  Globals.notes_array.tap &.each do |note|
    begin
      puts <<-NOTE
              #{"NOTE TITLE:".colorize(:yellow)} #{title}

              #{note[title]}
              NOTE

      count += 1
    rescue KeyError
      next
    end
  end

  if count == 0 
    return 1
  end

  return 0
end

# Function to delete specified note.
# Returns 0 if note was successfully deleted, 1 on failure.
def delete_note(title : String) : Int32
  count = 0

  Globals.notes_array.tap &.each do |note|
    note[title]
    count += 1
  rescue KeyError
    next
  else
    Globals.notes_array.delete note
  end

  if count == 0
    return 1
  end

  notes_to_json
  return 0
end
