require 'optparse'
require 'ostruct'

module Linenum
  class OptionParserExample
    def self.parse(args = ARGV)

      # Default options
      options = OpenStruct.new
      options.linenumbers = true

      option_parser = OptionParser.new do |opts|
        opts.banner = """
          Linenum prints lines from files preceded by a number ^_^

          Usage: 02_linenum [options] files...

          =======
        """

        opts.separator "Common options:"

        opts.on("--[no]-line", "-l", "Don't display the line numbers") do |l|
          options.linenumbers = l
        end

        opts.on("--first n", "-f", Integer, "Only print the first n lines") do |n|
          options.first = n
        end

        opts.separator "Other options:"

        opts.on_tail("--help", "-h", "Display this message") do
          puts opts
          exit 0
        end

        opts.on_tail("--version", "-v", "Show version") do
          puts "linenum #{VERSION}"
          exit 0
        end

        options
      end

      option_parser.parse!(args)

      # Enforce required arguments
      if ARGV.empty? or ARGV[0] == "-"
        $stderr.puts "files are a required argument"
        $stderr.puts option_parser
        exit 1
      end

      options
    end
  end
end
