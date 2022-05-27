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

      Flags:
      #{options_help_lines.join("\n")}

      BASE_HELP

      sub = <<-SUB_HELP
      
      Subcommands:
      #{sub_commands_help_lines.join("\n")}

      SUB_HELP
    end

    desc "notor: A command line note creator" 
    usage <<-USAGE
    Usage: notor [flags]
	   notor [subcommand] [flags] [arguments]
    USAGE
    help short: "-h"
    version "notor version 0.0.1\nWritten by pes18fan, 2022.", short: "-v"

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
