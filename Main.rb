require_relative 'Latex'
require_relative 'Parser'

puts "                 _    _      _                _             \n".blue.bold +
     "                | |  (_)    | |              | |            \n".blue.bold +
     "  ___ ___   ___ | | ___  ___| |__   __ _  ___| | _____ _ __ \n".blue.bold +
     " / __/ _ \\ / _ \\| |/ / |/ _ \\ '_ \\ / _` |/ __| |/ / _ \\ '__|\n".blue.bold +
     "| (_| (_) | (_) |   <| |  __/ | | | (_| | (__|   <  __/ |   \n".blue.bold +
     " \\___\\___/ \\___/|_|\\_\\_|\\___|_| |_|\\__,_|\\___|_|\\_\\___|_|   \n".blue.bold

puts "Software developed by Erwan AUBRY\n"

puts "=========================\n\n"

ARGV << '-h' if ARGV.empty?
options = {}
options[:verbose] = false
opt_parser = OptionParser.new do |parser|
  parser.on("-f", "--file FILENAME",
            "Require the FILENAME before executing your script") do |f|
    puts "[FILE] #{f}".blue
    options[:file] = f
  end
  parser.on("-v", "--verbose", "Enable the verbose mode") do
    options[:verbose] = true
  end
  parser.on_tail("-h", "--help", "Prints this help") do
    puts parser
    exit
  end
    
end.parse!

checking = Latex.new(options[:file])
checking.lex()

if options[:verbose] 
  checking.display()
end

exit(0)
