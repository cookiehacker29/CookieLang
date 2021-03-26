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
        latex = Latex.new("test/script/initIntTest.cookie")
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

    def testinitString
        latex = Latex.new("test/script/initStringTest.cookie")
        tokenModel = Struct.new(:id,:value,:pos)
        testtoken = [
            tokenModel.new(:cookstring,"cookstring",1),
            tokenModel.new(:space," ",2),
            tokenModel.new(:id,"value",3),
            tokenModel.new(:space," ",4),
            tokenModel.new(:equal,"=",5),
            tokenModel.new(:space," ",6),
            tokenModel.new(:string,"\"j'aime les cookies !\"",7)
        ]
        latex.lex()

        assert_equal latex.getToken().to_s, testtoken.to_s
    end

    def testinitChar
        latex = Latex.new("test/script/initCharTest.cookie")
        tokenModel = Struct.new(:id,:value,:pos)
        testtoken = [
            tokenModel.new(:cookchar,"cookchar",1),
            tokenModel.new(:space," ",2),
            tokenModel.new(:id,"value",3),
            tokenModel.new(:space," ",4),
            tokenModel.new(:equal,"=",5),
            tokenModel.new(:space," ",6),
            tokenModel.new(:char,"\'t\'",7)
        ]
        latex.lex()

        assert_equal latex.getToken().to_s, testtoken.to_s
    end

    def testinitFloat
        latex = Latex.new("test/script/initFloatTest.cookie")
        tokenModel = Struct.new(:id,:value,:pos)
        testtoken = [
            tokenModel.new(:cookfloat,"cookfloat",1),
            tokenModel.new(:space," ",2),
            tokenModel.new(:id,"value",3),
            tokenModel.new(:space," ",4),
            tokenModel.new(:equal,"=",5),
            tokenModel.new(:space," ",6),
            tokenModel.new(:float,"7.5f",7)
        ]
        latex.lex()

        assert_equal latex.getToken().to_s, testtoken.to_s
    end

    def testinitDouble
        latex = Latex.new("test/script/initDoubleTest.cookie")
        tokenModel = Struct.new(:id,:value,:pos)
        testtoken = [
            tokenModel.new(:cookdouble,"cookdouble",1),
            tokenModel.new(:space," ",2),
            tokenModel.new(:id,"value",3),
            tokenModel.new(:space," ",4),
            tokenModel.new(:equal,"=",5),
            tokenModel.new(:space," ",6),
            tokenModel.new(:double,"7.5",7)
        ]
        latex.lex()

        assert_equal latex.getToken().to_s, testtoken.to_s
    end

    def testinitBool
        latex = Latex.new("test/script/initBoolTest.cookie")
        tokenModel = Struct.new(:id,:value,:pos)
        testtoken = [
            tokenModel.new(:cookbool,"cookbool",1),
            tokenModel.new(:space," ",2),
            tokenModel.new(:id,"value",3),
            tokenModel.new(:space," ",4),
            tokenModel.new(:equal,"=",5),
            tokenModel.new(:space," ",6),
            tokenModel.new(:bool,"1b",7)
        ]
        latex.lex()

        assert_equal latex.getToken().to_s, testtoken.to_s
    end

    def testifOperation
        latex = Latex.new("test/script/ifOperationTest.cookie")
        tokenModel = Struct.new(:id,:value,:pos)
        testtoken = [
            tokenModel.new(:if,"if",1),
            tokenModel.new(:space, " ", 2),
            tokenModel.new(:openpar, "(",3),
            tokenModel.new(:id, "a", 4),
            tokenModel.new(:space, " ", 5),
            tokenModel.new(:lower, "<", 6),
            tokenModel.new(:space, " ", 7),
            tokenModel.new(:id, "b", 8),
            tokenModel.new(:closepar, ")", 9),
            tokenModel.new(:jump, "\n", 10),
            tokenModel.new(:space, " ", 11),
            tokenModel.new(:space, " ", 12),
            tokenModel.new(:space, " ", 13),
            tokenModel.new(:space, " ", 14),
            tokenModel.new(:id, "value", 15),
            tokenModel.new(:space, " ", 16),
            tokenModel.new(:addequal, "+=", 17),
            tokenModel.new(:space, " ", 18),
            tokenModel.new(:int, "5", 19),
            tokenModel.new(:jump, "\n", 20),
            tokenModel.new(:elif, "elif", 21),
            tokenModel.new(:space, " ", 22),
            tokenModel.new(:openpar, "(",23),
            tokenModel.new(:id, "a", 24),
            tokenModel.new(:space, " ", 25),
            tokenModel.new(:greater, ">", 26),
            tokenModel.new(:space, " ", 27),
            tokenModel.new(:id, "b", 28),
            tokenModel.new(:closepar, ")", 29),
            tokenModel.new(:jump, "\n", 30),
            tokenModel.new(:space, " ", 31),
            tokenModel.new(:space, " ", 32),
            tokenModel.new(:space, " ", 33),
            tokenModel.new(:space, " ", 34),
            tokenModel.new(:id, "value", 35),
            tokenModel.new(:space, " ", 36),
            tokenModel.new(:subequal, "-=", 37),
            tokenModel.new(:space, " ", 38),
            tokenModel.new(:int, "5", 39),
            tokenModel.new(:jump, "\n", 40),
            tokenModel.new(:else, "else", 41),
            tokenModel.new(:jump, "\n", 42),
            tokenModel.new(:space, " ", 43),
            tokenModel.new(:space, " ", 44),
            tokenModel.new(:space, " ", 45),
            tokenModel.new(:space, " ", 46),
            tokenModel.new(:id, "value", 47),
            tokenModel.new(:space, " ", 48),
            tokenModel.new(:divequal, "/=", 49),
            tokenModel.new(:space, " ", 50),
            tokenModel.new(:int, "5", 51),
            tokenModel.new(:jump, "\n", 52),
            tokenModel.new(:end, "end", 53)
        ]
        latex.lex()

        assert_equal latex.getToken().to_s, testtoken.to_s
    end

    ##
    # Method which test is the file is not found
    def testFileNotFound
        latex = Latex.new("cookie.cookie")
        assert_throw latex do 
            throw latex 
        end
    end


end

