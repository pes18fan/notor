class Globals
  @@version : String = {{ `shards version #{__DIR__}`.chomp.stringify }}
  @@files_dir : String = `echo $HOME/.notor`.chomp
  @@notes_file : String = `echo #{@@files_dir}/notes.json`.chomp

  @@notes_array = [] of Hash(String, String)

  def self.version
    @@version
  end

  def self.notes_array
    @@notes_array
  end

  def self.files_dir
    @@files_dir
  end

  def self.notes_file
    @@notes_file
  end
end