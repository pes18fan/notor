require "./note"

# Class holding global variables.
class Globals
  # Application version.
  @@version : String = {{ `shards version #{__DIR__}`.chomp.stringify }}

  # User's default text editor.
  @@default_editor : String = `echo $EDITOR`.chomp

  # User's default pager.
  @@default_pager : String = `echo $PAGER`.chomp

  # Path to directory where notor stores data.
  @@files_dir : String = `echo $HOME/.notor`.chomp

  # Path to file where the notes are stored in the json format.
  @@notes_file : String = `echo #{@@files_dir}/notes.json`.chomp

  # Temporary file created while editing a note.
  @@temp_file : String = `echo #{@@files_dir}/temp.txt`.chomp

  # Array holding all the notes at runtime.
  @@notes_array = [] of Hash(String, String)

  def self.version
    @@version
  end

  def self.default_editor
    @@default_editor
  end

  def self.default_pager
    @@default_pager
  end

  def self.files_dir
    @@files_dir
  end

  def self.notes_file
    @@notes_file
  end

  def self.temp_file
    @@temp_file
  end

  def self.notes_array
    @@notes_array
  end
end
