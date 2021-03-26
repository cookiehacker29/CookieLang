require 'strscan'
require 'logger'
require 'colorize'
require 'optparse'

##
# This class is used to check the cookieCode and generate a list of tokens which are a structure compose by an ID, a value and a position
#
# * Author : Erwan AUBRY (cookiehacker)
# * School : ENSTA-Bretagne
class Latex

    ##
    # Function constructor to create an instance of Latex class.
    #
    # ==== Attributes
    #
    # * +filename+ - The filename of the cookie script.
    #
    # ==== Examples
    #
    # Examples of using : 
    #
    #   latex = Lates.new("script.cookie")
    def initialize(filename)
        @src = ""
        @filename = filename
        @logger = Logger.new('logLatex.log')
        @logger.level = Logger::DEBUG
        @tokens = []
        @tokenModel = Struct.new(:id,:value,:pos)
    end

    ##
    # Private method to import code from a cookie script and check if the file exist
    private def importcode
        begin
            @logger.debug("Software started")
            if @filename == nil
                puts "File not specify".red
                @logger.error("File not specify")
                exit(-1)
            end
            @src = File.open(@filename,"r").read
            puts "File imported !".green
            @logger.debug("File imported")
            
        rescue
            puts "File not found !".red
            @logger.fatal("File not found !")
        end
    end

    ##
    # Method allow to check if the cookie script is lexicaly correct
    public def lex
        importcode()
        @tokens = []
        pos = 0
        while @src.size > 0
            pos+=1
            case @src
            
            # SPECIAL
            when /\A\n/
                @tokens << @tokenModel.new(:jump,$&,  pos) 
            when /\A\s/
                @tokens << @tokenModel.new(:space,$&,  pos)
            
            # COOKING
            when /\Acookint/
                @tokens << @tokenModel.new(:cookint,$&,  pos)
            when /\Acookstring/
                @tokens << @tokenModel.new(:cookstring,$&,  pos)
            when /\Acookchar/
                @tokens << @tokenModel.new(:cookchar,$&,  pos)
            when /\Acookfloat/
                @tokens << @tokenModel.new(:cookfloat,$&,  pos)
            when /\Acookdouble/
                @tokens << @tokenModel.new(:cookdouble,$&,  pos)
            when /\Acookbool/
                @tokens << @tokenModel.new(:cookbool,$&,  pos)
            
            # CONDITION
            when /\Aif/
                @tokens << @tokenModel.new(:if,$&,  pos)
            when /\Aifelse/
                @tokens << @tokenModel.new(:ifelse,$&,  pos)
            when /\Aelse/
                @tokens << @tokenModel.new(:else,$&,  pos)
            
            # EXIT
            when /\AcookieGoAwayAndSay/
                @tokens << @tokenModel.new(:cookiegoawayandsay,$&,  pos)
            
            # RETURN
            when /\Aeat/
                @tokens << @tokenModel.new(:eat,$&,  pos)
            
            # PRINT
            when /\Ashow/
                @tokens << @tokenModel.new(:show,$&,  pos)
            
            # VALUE
            when /\A".*"/
                @tokens << @tokenModel.new(:string,$&,  pos)
            when /\A[0|1]b/
                @tokens << @tokenModel.new(:bool,$&,  pos)
            when /\A(-)?([0-9]+)(.)([0-9]+)((e)(-)?[0-9]+)?f/
                @tokens << @tokenModel.new(:float,$&,  pos)
            when /\A(-)?([0-9]+)(.)([0-9]+)((e)(-)?[0-9]+)?/
                @tokens << @tokenModel.new(:double,$&,  pos)
            when /\A[0-9]+/
                @tokens << @tokenModel.new(:int,$&,  pos)
            when /\A[a-zA-Z]+/
                @tokens << @tokenModel.new(:id,$&,  pos)
        
            # SYMBOL
            when /\A\=/
                @tokens << @tokenModel.new(:equal,$&,  pos)
            when /\A\{/
                @tokens << @tokenModel.new(:openbraket,$&,  pos)
            when /\A\}/
                @tokens << @tokenModel.new(:closebraket,$&,  pos)
            when /\A\(/
                @tokens << @tokenModel.new(:openpar,$&,  pos)
            when /\A\)/
                @tokens << @tokenModel.new(:closepar,$&,  pos)
            
            # CONDITION SYMBOL
            when /\A\</
                @tokens << @tokenModel.new(:lower,$&,  pos)
            when /\A\<\=/
                @tokens << @tokenModel.new(:lowerandequal,$&,  pos)
            when /\A\>/
                @tokens << @tokenModel.new(:greater,$&,  pos)
            when /\A\>\=/
                @tokens << @tokenModel.new(:greaterandequal,$&,  pos)
            when /\A\=\=/
                @tokens << @tokenModel.new(:isequal,$&,  pos)
            when /\A\!\=/
                @tokens << @tokenModel.new(:notequal,$&,  pos)
                # ARITHMETIC OPERATOR
            when /\A\+\+/
                @tokens << @tokenModel.new(:incr,$&,  pos)
            when /\A\-\-/
                @tokens << @tokenModel.new(:decr,$&,  pos)
            when /\A\+\=/
                @tokens << @tokenModel.new(:addequal,$&, pos)
            when /\A\-\=/
                @tokens << @tokenModel.new(:subequal,$&, pos)
            when /\A\/\=/
                @tokens << @tokenModel.new(:divequal,$&, pos)
            when /\A\*\=/
                @tokens << @tokenModel.new(:multequal,$&, pos)
            when /\A\<\</
                @tokens << @tokenModel.new(:bls,$&, pos)
            when /\A\>\>/
                @tokens << @tokenModel.new(:brs,$&, pos)
            when /\A\+/
                @tokens << @tokenModel.new(:plus,$&,  pos)
            when /\A\-/
                @tokens << @tokenModel.new(:sub,$&,  pos)
            when /\A\*/
                @tokens << @tokenModel.new(:mult,$&,  pos)
            when /\A\//
                @tokens << @tokenModel.new(:div,$&,  pos)
                else
                @logger.fatal("Lexical error : #{@src[0..-1]}")
                raise "Lexical error : #{@src[0..-1]}"
            end
            @src.delete_prefix!($&)
        end
    end

    ##
    # Method to get the tokens
    def getToken
        @tokens
    end

    ##
    # Method to display result
    def display
        @tokens.each {|token| puts "#{token}".blue}
    end
end
