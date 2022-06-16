require "./notes"
require "./globals"
require "./note_handler"
require "colorize"
require "clim"

# This file manages the basic user interface, which includes command line flags, subcommands and args.

# Class that defines the flags, subcommands and arguments usable for the binary.
class Cli < Clim
  main do
    # This block defines the template for the program help shown when the binary is run with the `--help` flag.
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

    # Subcommand to create a new note.
    sub "new" do
      desc "Create a new note"
      usage "notor new [title] [content]"
      help short: "-h"

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
        elsif args.title.to_s.includes?("\n")
          puts "#{"ERROR:".colorize(:red)} Title cannot contain newlines!"
        else
          write_note(Note.new(args.title.to_s, args.content.to_s))
          puts "New note #{args.title.to_s} created!"
          exit
        end
      end
    end

    # Subcommand to print the specified note to stdout.
    sub "cat" do
      desc "Display the contents of the specified note"
      usage "notor cat [title]"
      help short: "-h"

      argument "title",
        desc: "The title of the note to print",
        type: String

      run do |opts, args|
        if args.title.to_s.empty?
          puts opts.help_string
        elsif !args.unknown_args.empty?
          puts "#{"ERROR:".colorize(:red)} Unknown arguments found! Please enter only the title, and if it's composed of multiple words place it in double quotes."
        else
          puts "Note \"#{args.title.to_s}\" not found." if cat(args.title.to_s) == 1
          exit
        end
      end
    end

    # Subcommand to edit specified note.
    sub "edit" do
      desc "Edit specified note"
      usage "notor edit [title]"
      help short: "-h"

      argument "title",
        desc: "Title of the note to delete",
        type: String

      argument "editor",
        desc: "Editor to use to edit the note",
        type: String

      run do |opts, args|
        if args.title.to_s.empty?
          puts opts.help_string
        elsif !args.unknown_args.empty?
          puts "#{"ERROR:".colorize(:red)} Unknown arguments found! Please enter only the title, and if it's composed of multiple words place it in double quotes."
        else
          case edit_note(args.title.to_s, args.editor.to_s)
          when 0
            puts "Note \"#{args.title.to_s}\" successfully edited."
          when 1
            puts "Failed to edit \"#{args.title.to_s}\"."
          when 2
            puts "Note \"#{args.title.to_s}\" not found."
          end
        end
      end
    end

    # Subcommand to delete specified note.
    sub "del" do
      desc "Delete specified note"
      usage "notor del [title]"
      help short: "-h"

      argument "title",
        desc: "Title of the note to delete",
        type: String

      run do |opts, args|
        if args.title.to_s.empty?
          puts opts.help_string
        elsif !args.unknown_args.empty?
          puts "#{"ERROR:".colorize(:red)} Unknown arguments found! Please enter only the title, and if it's composed of multiple words place it in double quotes."
        else
          if delete_note(args.title.to_s) == 1
            puts "Note \"#{args.title.to_s}\" not found."
          else
            puts "Note \"#{args.title.to_s}\" deleted."
          end
          exit
        end
      end
    end

    # Subcommand to list titles of all notes.
    sub "list" do
      desc "List the titles of all notes"
      usage "notor list"
      help short: "-h"

      run do
        list_notes
        exit
      end
    end

    # Subcommand to delete all notes.
    sub "reset" do
      desc "Delete all notes"
      usage "notor reset"
      help short: "-h"

      run do
        reset_notes
        puts "All notes deleted."
        exit
      end
    end

    # Block that runs if no args are specified.
    run do |opts, args|
      puts opts.help_string
    end
  end
end