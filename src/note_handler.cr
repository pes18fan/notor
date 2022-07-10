require "json"

# This file defines functions for various actions done on the notes, like adding new ones or deleting existing ones.

# Function to write all notes in the global notes array to a json file.
def notes_to_json
  notes_json_string = JSON.build do |json|
    json.object do
      json.field "note_number", Globals.notes_array.size
      json.field "notes" do
        json.array do
          Globals.notes_array.tap &.each do |note|
            note.tap &.each do |title, content|
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
# Returns 0 on success, 1 if note already exists.
def write_note(title : String, content : String) : Int32
  Globals.notes_array.tap &.each do |i|
    _ = i[title]
  rescue KeyError
    next
  else
    return 1
  end

  note = {} of String => String
  note[title] = content
  
  Globals.notes_array << note

  notes_to_json
  return 0
end

# Function to edit an existing note.
# Returns 0 on succesful edit, 1 on failure, and 2 if specifed note does not exist.
def edit_note(title : String, editor : String = "") : Int32
  used_text_editor = uninitialized String

  Globals.notes_array.tap &.each do |note|
    _ = note[title]
  rescue KeyError
    next
  else
    temp_file = File.new(Globals.temp_file, "w")

    note.tap &.each do |title, content|
      temp_file.puts "# DO NOT REMOVE THIS LINE. Edit the note below. The first line below is the title and the lines afterward include the content."
      temp_file.puts title
      temp_file.puts content
    end

    temp_file.close

    # This nested mess decides what editor is used for editing the note.
    # It first checks the args for the editor, if no editor was specified it checks configuration for the editor, if that is also unset it then checks the default text editor, and if that is also empty it finally falls back to vi.
    unless editor.empty?
      used_text_editor = editor
    else
      unless Config.editor.empty?
        used_text_editor = Config.editor
      else
        unless Globals.default_editor.empty?
          used_text_editor = Globals.default_editor
        else
          used_text_editor = "vi"
          puts "No default editor detected and no editor specified. Using vi, press enter to continue."
          gets
        end
      end
    end

    system("#{used_text_editor} #{Globals.temp_file}")
  end

  file_content = File.read_lines(Globals.temp_file)
  file_content.delete file_content[0]

  if file_content[0].empty? || file_content[1..].empty?
    puts "#{"ERROR:".colorize(:red)} Cannot create a note with empty title or content! Aborting edit."
    File.delete(Globals.temp_file)
    return 1
  end

  count = 0

  Globals.notes_array.tap &.each do |note|
    _ = note[title]
    count += 1
  rescue KeyError
    next
  else
    note[file_content[0]] = note.delete(title).to_s
    note[file_content[0]] = file_content[1..].join("\n")
  end

  return 2 if count == 0

  File.delete(Globals.temp_file)

  notes_to_json

  return 0
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
def cat(title : String, use_pager : Bool) : Int32
  count = 0

  Globals.notes_array.tap &.each do |note|
    _ = note[title]
    count += 1
  rescue KeyError
    next
  else
    printed_content = <<-NOTE
    #{"NOTE TITLE:".colorize(:yellow)} #{title}

    #{note[title]}
    NOTE

    if Config.paging == true
      unless Config.pager.empty?
        system("echo \"#{printed_content}\" | #{Config.pager}")
      else
        unless Globals.default_pager.empty?
          system("echo \"#{printed_content}\" | #{Globals.default_pager}")
        else
          system("echo \"#{printed_content}\" | less")
        end
      end

      return 0
    end

    if use_pager
      unless Config.pager.empty?
        system("echo \"#{printed_content}\" | #{Config.pager}")
      else
        unless Globals.default_pager.empty?
          system("echo \"#{printed_content}\" | #{Globals.default_pager}")
        else
          system("echo \"#{printed_content}\" | less")
        end
      end
    else
      puts printed_content
    end
  end

  return 1 if count == 0

  return 0
end

# Function to delete specified note.
# Returns 0 if note was successfully deleted, 1 on failure.
def delete_note(title : String) : Int32
  count = 0

  Globals.notes_array.tap &.each do |note|
    _ = note[title]
    count += 1
  rescue KeyError
    next
  else
    Globals.notes_array.delete note
  end

  return 1 if count == 0

  notes_to_json

  return 0
end

# Function to list all notes.
def list_notes
  if Globals.notes_array.size == 0
    puts "No notes to list."
    return
  end

  count = 1
  puts "#{Globals.notes_array.size} notes present."
  puts "#{"All notes:".colorize(:yellow)}"

  Globals.notes_array.tap &.each do |note|
    note.tap &.each do |title, content|
      puts "\t#{count}.\t#{title}"
      count += 1
    end
  end
end
