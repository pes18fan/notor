require "./globals"
require "colorize"
require "clim"

class Cli < Clim
  main do
    help_template do |desc, usage, options, arguments, sub_commands|
      options_help_lines = options.map do |option|
	"\t#{option[:names].join(", ").colorize(:green).on(:black)}\t#{option[:desc]}"
      end

      sub_commands_help_lines = sub_commands.map do |sub_command|
	"\t#{sub_command[:names].join(", ").colorize(:green).on(:black)}\t#{sub_command[:desc]}"
      end

      base = <<-BASE_HELP
      #{desc}

      #{usage}

      #{"FLAGS:".colorize(:yellow).on(:black)}
      #{options_help_lines.join("\n")}

      BASE_HELP

      sub = <<-SUB_HELP
      
      #{"SUBCOMMANDS:".colorize(:yellow).on(:black)}
      #{sub_commands_help_lines.join("\n")}

      SUB_HELP

      base + sub
    end

    desc <<-DESC
    #{"notor".colorize(:green).on(:black)} #{Globals.version}
    A command line note creator.
    DESC

    usage <<-USAGE
    #{"USAGE:".colorize(:yellow).on(:black)}
    \tnotor [flags]
    \tnotor [subcommand] [flags] [arguments]
    USAGE

    help short: "-h"
    version "notor version #{Globals.version}\nWritten by pes18fan, 2022.", short: "-v"

    sub "pog" do
      desc "poggers!"
      usage "notor pog"
      run do |opts, args|
        puts "POGGGGGGGGGGGGGERRRRRRRRRSSSSS!!!!!!"
        exit
      end
    end

    run do |opts, args|
      if args.all_args.empty?
	puts opts.help_string
      else
	puts "#{"ERROR:".colorize(:red).on(:black)} Invalid subcommand. \"#{args.all_args.first}\""
	puts "\nPlease see the `--help`."
      end
      exit
    end
  end
end
