require "./notes"
require "./globals"
require "./note_to_file"
require "colorize"
require "clim"

class Cli < Clim
  main do
    help_template do |desc, usage, options, arguments, sub_commands|
      options_help_lines = options.map do |option|
        "\t#{option[:names].join(", ").colorize(:green)}\t#{option[:desc]}"
      end

      arguments_help_lines = arguments.map do |argument|
        "\t#{argument[:display_name].colorize(:green)}\t#{argument[:desc]}"
      end

      sub_commands_help_lines = sub_commands.map do |sub_command|
        "\t#{sub_command[:names].join(", ").colorize(:green)}\t#{sub_command[:desc]}"
      end

      base = <<-BASE_HELP
      #{desc}

      #{"USAGE:".colorize(:yellow)} #{usage}

      #{"FLAGS:".colorize(:yellow)}
      #{options_help_lines.join("\n")}

      BASE_HELP

      args = <<-ARGS_HELP

      #{"ARGUMENTS:".colorize(:yellow)}
      #{arguments_help_lines.join("\n")}

      ARGS_HELP

      sub = <<-SUB_HELP 

      #{"SUBCOMMANDS:".colorize(:yellow)}
      #{sub_commands_help_lines.join("\n")}

      SUB_HELP

      if arguments.empty? && sub_commands.empty?
        base
      elsif arguments.empty? && !sub_commands.empty?
        base + sub
      elsif sub_commands.empty? && !arguments.empty?
        base + args
      else
        base + sub + args
      end
    end

    desc <<-DESC
    #{"notor".colorize(:green)} #{Globals.version}
    A command line note creator.
    DESC

    usage <<-USAGE

    \tnotor [flags]
    \tnotor [subcommand] [flags] [arguments]
    USAGE

    help short: "-h"
    version "notor version #{Globals.version}\nWritten by pes18fan, 2022.", short: "-v"

    sub "new" do
      desc "Create a new note"
      usage "notor new [TITLE] [CONTENT]"

      argument "title",
        desc: "The title of the note",
        type: String

      argument "content",
        desc: "The content of the note",
        type: String

      run do |opts, args|
        if args.all_args.empty?
          puts opts.help_string
        elsif !args.unknown_args.empty?
          puts "#{"ERROR:".colorize(:red)} Unknown arguments found! If the title or content is composed of multiple words, please enter them in double quotes."
        elsif args.title.to_s.empty? || args.content.to_s.empty?
          puts "#{"ERROR:".colorize(:red)} Please specify non-empty title and content!"
        else
          write_note(Note.new(args.title.to_s, args.content.to_s))
          puts "New note #{args.title.to_s} created!"
          exit
        end
      end
    end

    sub "num" do
      desc "Display number of notes present"
      usage "notor num"
      run do |opts, args|
        puts "#{Note.number_of_notes} notes present."
        exit
      end
    end

    run do |opts, args|
      puts opts.help_string
    end
  end
end