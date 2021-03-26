require 'simplecov'
SimpleCov.start 'rails'

require 'test/unit'
require_relative '../Latex'

##
# This class allow to test the Latex Test
#
# * Author : Erwan AUBRY (cookiehacker)
# * School : ENSTA-Bretagne
# * Version : 1.0
class TestLatex < Test::Unit::TestCase

    ##
    # Method which test the initialization of Integer
    def testInitInteger
        latex = Latex.new("test/initTest.cookie")
        tokenModel = Struct.new(:id,:value,:pos)
        testtoken = [
            tokenModel.new(:cookint,"cookint",1),
            tokenModel.new(:space," ",2),
            tokenModel.new(:id,"cookie",3),
            tokenModel.new(:space," ",4),
            tokenModel.new(:equal,"=",5),
            tokenModel.new(:space," ",6),
            tokenModel.new(:int,"4",7)
        ]
        latex.lex()

        

        assert_equal latex.getToken().to_s, testtoken.to_s
    end
end

