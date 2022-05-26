require "clim"

class Cli < Clim
  main do
    help_template do |desc, usage, options, arguments, sub_commands|
      options_help_lines = options.map do |option|
	"\t" + option[:names].join(", ") + "\t" + "#{option[:desc]}"
      end

      sub_commands_help_lines = sub_commands.map do |sub_command|
	"\t" + sub_command[:names].join(", ") + "\t" + "#{sub_command[:desc]}"
      end

      base = <<-BASE_HELP
      #{desc}

      #{usage}

      Options:
      #{options_help_lines.join("\n")}

      BASE_HELP

      sub = <<-SUB_HELP
      
      Subcommands:
      #{sub_commands_help_lines.join("\n")}

      SUB_HELP

      sub_commands.empty? ? base : base + sub
    end

    desc "notor: A command line note creator" 
    usage <<-USAGE 
    Usage: notor [options] [arguments]
    USAGE
    help short: "-h"
    version "version 0.0.1", short: "-v"

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
	puts "ERROR: Invalid subcommand. \"#{args.all_args.first}\""
	puts "\nPlease see the `--help`."
      end
      exit
    end
  end
end
