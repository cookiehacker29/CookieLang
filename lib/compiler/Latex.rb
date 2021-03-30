require 'strscan'
require 'logger'
require 'colorize'
require 'optparse'

require_relative 'LatexChecker'

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
    def initialize(filename)
        @src = ""
        @filename = filename
        @logger = Logger.new('log/logLatex.log')
        @logger.level = Logger::DEBUG
        @tokens = []
        @tokenModel = Struct.new(:id,:value,:pos)
        @pos = 0
        @rules = [
            LatexChecker::SpecialLatex,
            LatexChecker::CookingLatex,
            LatexChecker::ConditionLatex,
            LatexChecker::LoopLatex,
            LatexChecker::KeywordLatex,
            LatexChecker::ValueLatex,
            LatexChecker::ArithmeticOperatorAdvancedLatex,
            LatexChecker::ArithmeticOperatorLatex,
            LatexChecker::ConditionSymbolLatex,
            LatexChecker::SymbolLatex
        ]
    end

    ##
    # Private method to import code from a cookie script and check if the file exist
    private def importcode
        begin
            @logger.debug("Software started")
            raise FileNotSpecifyError if @filename == nil
            @src = File.open(@filename,"r").read
            puts "File imported !".green
            @logger.debug("File imported")
            
        rescue
            puts "File not found !".red
            @logger.fatal("File not found !")
        end
    end

    private def checking
        status = false
        data = @src
        ind = 0
        while(status == false && ind <= (@rules.length()-1))
            status, data = @rules[ind].check(@src,@tokens,@pos,@tokenModel)
            ind+=1
        end
        [status,data]
    end

    ##
    # Method allow to check if the cookie script is lexicaly correct
    public def lex
        importcode()
        @tokens = []
        while @src.size > 0
            @pos+=1
            status,data = checking()
            if !status
                @logger.fatal("Lexical error : #{@src[0..-1]}")
                raise "Lexical error : #{@src[0..-1]}"
            end
            @src.delete_prefix!(data)
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
        @tokens.each {|token| puts "#{token}"}
    end
end
