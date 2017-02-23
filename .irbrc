require 'rubygems'
require 'active_record'

alias q exit


class Object
  def local_methods
    (methods - Object.instance_methods).sort
  end
end

ANSI = {}
ANSI[:RESET] = "\e[0m"
ANSI[:BOLD] = "\e[1m"
ANSI[:UNDERLINE] = "\e[4m"
ANSI[:LGRAY] = "\e[0;37m"
ANSI[:GRAY] = "\e[1;30m"
ANSI[:RED] = "\e[31m"
ANSI[:GREEN] = "\e[32m"
ANSI[:YELLOW] = "\e[33m"
ANSI[:BLUE] = "\e[34m"
ANSI[:MAGENTA] = "\e[35m"
ANSI[:CYAN] = "\e[36m"
ANSI[:WHITE] = "\e[37m"

# Build a simple colorful IRB prompt
IRB.conf[:PROMPT][:SIMPLE_COLOR] = {
  :PROMPT_I => "#{ANSI[:BLUE]}>>#{ANSI[:RESET]} ",
  :PROMPT_N => "#{ANSI[:BLUE]}>>#{ANSI[:RESET]} ",
  :PROMPT_C => "#{ANSI[:RED]}?>#{ANSI[:RESET]} ",
  :PROMPT_S => "#{ANSI[:YELLOW]}?>#{ANSI[:RESET]} ",
  :RETURN => "#{ANSI[:GREEN]}=>#{ANSI[:RESET]} %s\n",
  :AUTO_INDENT => true }
IRB.conf[:PROMPT_MODE] = :SIMPLE_COLOR

if ENV['RAILS_ENV']
  IRB.conf[:IRB_RC] = Proc.new do

    # Let you use Model[id] to find by id
    class ActiveRecord::Base
      def self.[](index)
        find_by_id(index)
      end
    end

    # Shortcuts for finding things by symbol
    def Fund(symbol)
      Fund.where(:symbol => symbol.to_s).first
    end

    def Stock(symbol)
      Stock.where(:symbol => symbol.to_s).first
    end

    # Log SQL queries to stdout
    ActiveRecord::Base.connection.instance_variable_set :@logger, Logger.new(STDOUT)

    # For marshalling session data
    def load_session(session_data)
      Marshal.load(Base64.decode64(session_data.split('--').first))
    end
  end
end

require 'rubygems'
require 'active_record'
require 'awesome_print'

alias q exit

class Object
  def local_methods
    (methods - Object.instance_methods).sort
  end
end

if ENV['RAILS_ENV']
  IRB.conf[:IRB_RC] = Proc.new do

    # Let you use Model[id] to find by id
    class ActiveRecord::Base
      def self.[](index)
        find_by_id(index)
      end
    end

    # Shortcuts for finding things by symbol
    def Fund(symbol)
      Fund.where(:symbol => symbol.to_s).first
    end

    def Stock(symbol)
      Stock.where(:symbol => symbol.to_s).first
    end

    # Log SQL queries to stdout
    # ConsoleUtil.output_sql_to_console
    AwesomePrint.irb!

    # For marshalling session data
    def load_session(session_data)
      Marshal.load(Base64.decode64(session_data.split('--').first))
    end
  end
end
