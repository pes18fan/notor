require "option_parser"

OptionParser.parse do |parser|
  parser.banner = "notor: A simple note taking app"

  parser.on "-v", "--version", "Show the app version." do
    puts "notor version 0.0.1"
    puts "Written by pes18fan, 2022."
    exit
  end

  parser.on "-h", "--help", "Show this help dialog." do
    puts parser
    exit
  end

  parser.missing_option do |flag|
    STDERR.puts "ERROR: #{flag} is missing something."
    STDERR.puts ""
    STDERR.puts parser
    exit(1)
  end

  parser.invalid_option do |flag|
    STDERR.puts "ERROR: The flag #{flag} does not exist."
    STDERR.puts ""
    STDERR.puts parser
    exit(1)
  end

  if ARGV.size == 0
      puts parser
      exit
  end
end
