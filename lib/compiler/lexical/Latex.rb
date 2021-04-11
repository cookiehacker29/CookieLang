require 'strscan'
require 'logger'
require 'colorize'
require 'optparse'

##
# This class is an exception in the case if the file isn't specify
class FileNotSpecifyError < StandardError; end

##
# This class is used to check the cookieCode and generate a list of tokens which are a structure compose by an ID, a value and a position
#
# * Author : Erwan AUBRY (cookiehacker)
# * School : ENSTA-Bretagne
# * Version : 1.0
class Latex

    RULES={
        # Special char
        :comment => /\#.[^\\]*/,
        :jump => /\n/,
        :space => /\s/,
        :sep => /\,/,

        # Cooking
        :cookint => /cookint/,
        :cookstring => /cookstring/,
        :cookchar => /cookchar/,
        :cookdouble => /cookdouble/,
        :cookbool => /cookbool/,

        # Condition
        :if => /if/,
        :elif => /elif/,
        :else => /else/,

        # Loop
        :for => /for/,
        :while => /while/,

        # Keyword
        :cookiegoawayandsay => /cookiegoawayandsay/,
        :eat => /eat/,
        :show => /show/,
        :end => /end/,
        :cookiedough => /cookiedough/,

        # Value
        :char => /\'[a-zA-Z]\'/,
        :string => /".*"/,
        :bool => /[0|1]b/,
        :double => /(\-)?([0-9]+)(\.)([0-9]+)((e)(\-)?[0-9]+)?/,
        :int => /[0-9]+/,
        :id => /[a-zA-Z]+/,

        # Arithmetic Operator
        :incr => /\+\+/,
        :decr => /\-\-/,
        :addequal => /\+\=/,
        :subequal => /\-\=/,
        :divequal => /\/\=/,
        :multequal => /\*\=/,
        :bls => /\<\</,
        :brs => /\>\>/,
        :plus => /\+/,
        :sub => /\-/,
        :mult => /\*/,
        :div => /\//,

        # Condition symbol
        :greaterandequal => /\>\=/,
        :lowerandequal => /\<\=/,
        :lower => /\</,
        :greater => /\>/,
        :isequal => /\=\=/,
        :notequal => /\!\=/,

        # Other symbol
        :equal => /\=/,
        :openpar => /\(/,
        :closepar => /\)/,
    }

    ##
    # Function constructor to create an instance of Latex class.
    #
    # ==== Arguments
    #
    # * +filename+ - (String) The filename of the cookie script.
    #
    # ==== Examples
    #
    # Examples of using : 
    #
    #   latex = Latex.new("script.cookie")
    def initialize(filename, verbose)
        @src = ""
        @verbose = verbose
        @filename = filename
        @logger = Logger.new('log/logLatex.log')
        @logger.level = Logger::DEBUG
        @tokens = []
        @tokenModel = Struct.new(:id,:value,:pos)
        @pos = 0
    end

    ##
    # Private method to import code from a cookie script and check if the file exist
    private def importcode
        begin
            @logger.debug("Software started")
            raise FileNotSpecifyError if @filename == nil
            @src = File.open(@filename,"r").read
            puts "[OK] File imported !".green if @verbose
            @logger.debug("File imported")
            
        rescue
            puts "File not found !".red if @verbose
            @logger.fatal("File not found !")
        end
    end

    ##
    # Method allow to check if the cookie script is lexicaly correct
    public def lex
        importcode()
        error = false
        @tokens = []
        while @src.size != 0 && error != true
            @pos+=1
            RULES.each do |k,v|
                if m = @src.match(/\A#{v}/)
                    val=m[0]
                    @tokens << @tokenModel.new(k,val,@pos)
                    @src=m.post_match
                    error = false
                    break
                else
                    error = true
                end
            end
        end
        if error
            raise "Syntax error : expecting #{kind}. Got '#{@pos}'"
        end
    end

    ##
    # Method to get the tokens
    def getToken
        @tokens
    end

    ##
    # Method to display result
    def to_s
        result = ""
        @tokens.each {|token| result += "#{token}\n"}
        result
    end
end
