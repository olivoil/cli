require 'linenum/version'
require 'linenum/option_parser_example'

module Linenum
  module_function

  def run(args = ARGV, preamble = '')
    options = Linenum::OptionParserExample.parse(args)

    # Exit with non-zero exit status if arguments are not files
    args.each do |file|
      abort "Can't find #{file}" unless File.exists?(file)
    end

    # IO#tty? indicates if the output is a terminal
    puts preamble if $stdout.tty?

    # ARGF concatenates all files given as arguments
    ARGF.each do |line|
      puts options.linenumbers ? "%3d\t%s" % [ARGF.lineno, line]
                               : "%s" % line
      if options.first && ARGF.lineno >= options.first
        exit 0
      end
    end
  end

end
