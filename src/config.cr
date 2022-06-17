require "json"
require "colorize"

# Class that holds global variables that can be configured by the user.
class Config
  # Configuration file.
  @@file : String = `echo #{Globals.files_dir}/config.json`.chomp

  # Default editor for editing notes.
  @@editor : String = ""

  # Default pager for viewing notes.
  @@pager : String = ""

  # Sets default editor to use for editing notes.
  def self.conf_editor(editor : String)
    @@editor += editor
    Config.save
  end

  # Sets default pager to use for showing notes.
  def self.conf_pager(pager : String)
    @@pager += pager
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
  end

  # Saves configuration info to a json file.
  def self.save
    config = JSON.build do |json|
      json.object do
	json.field "editor", @@editor
	json.field "pager", @@pager
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
    \tEditor: #{@@editor}
    \tPager: #{@@pager}
    CONFIG
  end

  def self.editor
    @@editor
  end

  def self.pager
    @@pager
  end
end
