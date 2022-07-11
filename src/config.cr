require "json"
require "colorize"

# Class that holds global variables that can be configured by the user.
class Config
  # Configuration file.
  @@file : String = `echo #{Globals.files_dir}/config.json`.chomp

  # Default editor for editing notes.
  @@editor = ""

  # Default pager for viewing notes.
  @@pager = ""

  # Determines whether the pager is always used for viewing notes. False by default.
  @@paging = false

  # Sets default editor to use for editing notes.
  def self.conf_editor(editor : String)
    @@editor = editor
    Config.save
  end

  # Sets default pager to use for showing notes.
  def self.conf_pager(pager : String)
    @@pager = pager
    Config.save
  end

  # 
  def self.conf_paging(paging : Bool | Nil)
    @@paging = paging
    Config.save
  end

  # Pulls configuration info from the a config file if it exists.
  def self.pull
    unless File.exists?(@@file)
      return
    end

    config = File.open(@@file) do |file|
      JSON.parse(file)
    end

    @@editor = config["editor"].as_s
    @@pager = config["pager"].as_s
    @@paging = config["paging"].as_bool
  end

  # Saves configuration info to a json file.
  def self.save
    config = JSON.build do |json|
      json.object do
        json.field "editor", @@editor
        json.field "pager", @@pager
        json.field "paging", @@paging
      end
    end

    config_file = File.open(@@file, "w")
    config_file.puts config
    config_file.close
  end

  # Prints configuration info to stdout.
  def self.show
    puts <<-CONFIG
    #{"CONFIGURATION:".colorize(:yellow)}
    \tDefault editor: #{@@editor.empty? ? "none" : @@editor}
    \tDefault pager: #{@@pager.empty? ? "none" : @@pager}
    \tPaging always used: #{@@paging.to_s}
    CONFIG
  end

  # Resets the configuration settings.
  def self.reset
    File.delete(@@file)
  end

  def self.editor
    @@editor
  end

  def self.pager
    @@pager
  end

  def self.paging
    @@paging
  end
end
