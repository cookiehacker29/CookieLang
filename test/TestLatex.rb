require 'simplecov'
SimpleCov.start 'rails'

require 'test/unit'
require_relative '../lib/compiler/lexical/Latex'

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
        latex = Latex.new("test/script/initIntTest.cookie", false)
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

    ##
    # Method which test the initialization of String
    def testinitString
        latex = Latex.new("test/script/initStringTest.cookie", false)
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

    ##
    # Method which test the initialization of Char
    def testinitChar
        latex = Latex.new("test/script/initCharTest.cookie", false)
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

    ##
    # Method which test the initialization of Float
    def testinitFloat
        latex = Latex.new("test/script/initFloatTest.cookie", false)
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

    ##
    # Method which test the initialization of Double
    def testinitDouble
        latex = Latex.new("test/script/initDoubleTest.cookie", false)
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

    ##
    # Method which test the initialization of Bool
    def testinitBool
        latex = Latex.new("test/script/initBoolTest.cookie", false)
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

    ##
    # Method which test the "if operation"
    def testifOperation
        latex = Latex.new("test/script/ifOperationTest.cookie", false)
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
    # Method which test the "for loop"
    def testforLoopTest
        latex = Latex.new("test/script/forLoopTest.cookie", false)
        tokenModel = Struct.new(:id,:value,:pos)
        testtoken = [
            tokenModel.new(:for,"for",1),
            tokenModel.new(:space," ",2),
            tokenModel.new(:openpar, "(",3),
            tokenModel.new(:cookint,"cookint",4),
            tokenModel.new(:space," ",5),
            tokenModel.new(:id,"i",6),
            tokenModel.new(:space," ",7),
            tokenModel.new(:equal,"=",8),
            tokenModel.new(:space," ",9),
            tokenModel.new(:int,"0",10),
            tokenModel.new(:sep,",",11),
            tokenModel.new(:space," ",12),
            tokenModel.new(:id,"i",13),
            tokenModel.new(:space," ",14),
            tokenModel.new(:lower,"<",15),
            tokenModel.new(:space," ",16),
            tokenModel.new(:int,"50",17),
            tokenModel.new(:sep,",",18),
            tokenModel.new(:space," ",19),
            tokenModel.new(:id,"i",20),
            tokenModel.new(:incr,"++",21),
            tokenModel.new(:closepar,")",22),
            tokenModel.new(:jump,"\n",23),
            tokenModel.new(:space," ",24),
            tokenModel.new(:space," ",25),
            tokenModel.new(:space," ",26),
            tokenModel.new(:space," ",27),
            tokenModel.new(:show,"show",28),
            tokenModel.new(:openpar, "(",29),
            tokenModel.new(:id,"i",30),
            tokenModel.new(:closepar,")",31),
            tokenModel.new(:jump,"\n",32),
            tokenModel.new(:end,"end",33)
        ]
        latex.lex()

        assert_equal latex.getToken().to_s, testtoken.to_s
    end

    ##
    # Method which test the "while loop"
    def testwhileLoop
        latex = Latex.new("test/script/whileLoopTest.cookie", false)
        tokenModel = Struct.new(:id,:value,:pos)
        testtoken = [
            tokenModel.new(:while,"while",1),
            tokenModel.new(:space," ",2),
            tokenModel.new(:openpar, "(",3),
            tokenModel.new(:id,"a",4),
            tokenModel.new(:space," ",5),
            tokenModel.new(:notequal,"!=",6),
            tokenModel.new(:space," ",7),
            tokenModel.new(:id,"b",8),
            tokenModel.new(:closepar,")",9),
            tokenModel.new(:jump,"\n",10),
            tokenModel.new(:space," ",11),
            tokenModel.new(:space," ",12),
            tokenModel.new(:space," ",13),
            tokenModel.new(:space," ",14),
            tokenModel.new(:id,"a",15),
            tokenModel.new(:decr,"--",16),
            tokenModel.new(:jump,"\n",17),
            tokenModel.new(:space," ",18),
            tokenModel.new(:space," ",19),
            tokenModel.new(:space," ",20),
            tokenModel.new(:space," ",21),
            tokenModel.new(:show,"show",22),
            tokenModel.new(:openpar, "(",23),
            tokenModel.new(:id,"a",24),
            tokenModel.new(:closepar,")",25),
            tokenModel.new(:jump,"\n",26),
            tokenModel.new(:end,"end",27)
        ]
        latex.lex()

        assert_equal latex.getToken().to_s, testtoken.to_s
    end

    ##
    # Method which test the creation of functions
    def testFunction
        latex = Latex.new("test/script/functionTest.cookie", false)
        tokenModel = Struct.new(:id,:value,:pos)
        testtoken = [
            tokenModel.new(:cookiedough,"cookiedough",1),
            tokenModel.new(:space, " ", 2),
            tokenModel.new(:id,"myFunction",3),
            tokenModel.new(:openpar, "(",4),
            tokenModel.new(:closepar,")",5),
            tokenModel.new(:jump,"\n",6),
            tokenModel.new(:space," ",7),
            tokenModel.new(:space," ",8),
            tokenModel.new(:space," ",9),
            tokenModel.new(:space," ",10),
            tokenModel.new(:cookint,"cookint",11),
            tokenModel.new(:space," ",12),
            tokenModel.new(:id,"a",13),
            tokenModel.new(:equal,"=",14),
            tokenModel.new(:int,"5",15),
            tokenModel.new(:plus,"+",16),
            tokenModel.new(:int,"2",17),
            tokenModel.new(:sub,"-",18),
            tokenModel.new(:int,"5",19),
            tokenModel.new(:mult,"*",20),
            tokenModel.new(:openpar, "(",21),
            tokenModel.new(:int,"8",22),
            tokenModel.new(:div,"/",23),
            tokenModel.new(:int,"2",24),
            tokenModel.new(:closepar,")",25),
            tokenModel.new(:jump,"\n",26),
            tokenModel.new(:space," ",27),
            tokenModel.new(:space," ",28),
            tokenModel.new(:space," ",29),
            tokenModel.new(:space," ",30),
            tokenModel.new(:id,"a",31),
            tokenModel.new(:multequal,"*=",32),
            tokenModel.new(:int,"2",33),
            tokenModel.new(:jump,"\n",34),
            tokenModel.new(:space," ",35),
            tokenModel.new(:space," ",36),
            tokenModel.new(:space," ",37),
            tokenModel.new(:space," ",38),
            tokenModel.new(:id,"a",39),
            tokenModel.new(:equal,"=",40),
            tokenModel.new(:id,"a",41),
            tokenModel.new(:brs,">>",42),
            tokenModel.new(:int,"5",43),
            tokenModel.new(:jump,"\n",44),
            tokenModel.new(:space," ",45),
            tokenModel.new(:space," ",46),
            tokenModel.new(:space," ",47),
            tokenModel.new(:space," ",48),
            tokenModel.new(:id,"a",49),
            tokenModel.new(:equal,"=",50),
            tokenModel.new(:id,"a",51),
            tokenModel.new(:bls,"<<",52),
            tokenModel.new(:int,"5",53),
            tokenModel.new(:jump,"\n",54),
            tokenModel.new(:space," ",55),
            tokenModel.new(:space," ",56),
            tokenModel.new(:space," ",57),
            tokenModel.new(:space," ",58),
            tokenModel.new(:eat,"eat",59),
            tokenModel.new(:space," ",60),
            tokenModel.new(:id,"a",61),
            tokenModel.new(:jump,"\n",62),
            tokenModel.new(:end,"end",63)
        ]
        latex.lex()

        assert_equal latex.getToken().to_s, testtoken.to_s
    end

    ##
    # Method which test a script
    def testscript
        latex = Latex.new("test/script/scriptTest.cookie", false)
        tokenModel = Struct.new(:id,:value,:pos)
        testtoken = [
            tokenModel.new(:cookbool,"cookbool",1),
            tokenModel.new(:space," ",2),
            tokenModel.new(:id,"a",3),
            tokenModel.new(:equal,"=",4),
            tokenModel.new(:int,"5",5),
            tokenModel.new(:lowerandequal, "<=", 6),
            tokenModel.new(:int,"5",7),
            tokenModel.new(:jump,"\n",8),
            tokenModel.new(:cookbool,"cookbool",9),
            tokenModel.new(:space," ",10),
            tokenModel.new(:id,"b",11),
            tokenModel.new(:equal,"=",12),
            tokenModel.new(:int,"8",13),
            tokenModel.new(:greaterandequal, ">=", 14),
            tokenModel.new(:int,"5",15),
            tokenModel.new(:jump,"\n",16),
            tokenModel.new(:cookbool,"cookbool",17),
            tokenModel.new(:space," ",18),
            tokenModel.new(:id,"c",19),
            tokenModel.new(:equal,"=",20),
            tokenModel.new(:id,"a",21),
            tokenModel.new(:isequal, "==", 22),
            tokenModel.new(:int,"5",23),
            tokenModel.new(:jump,"\n",24),
            tokenModel.new(:jump,"\n",25),
            tokenModel.new(:cookiegoawayandsay, "cookiegoawayandsay",26),
            tokenModel.new(:space," ",27),
            tokenModel.new(:int,"0",28)
        ]
        latex.lex()

        assert_equal latex.getToken().to_s, testtoken.to_s
    end

    ##
    # Method which test the "to_s" function
    def testDisplay
        latex = Latex.new("test/script/initIntTest.cookie", false)
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

        v1 = ""
        testtoken.each {|token| v1 += "#{token}\n"}
        v2 = latex.to_s

        assert_equal v1.to_s ,v2.to_s
    end
    
    ##
    # Method which test the error "file is not found"
    def testFileNotFound
        latex = Latex.new("cookie.cookie", false)
        latex.lex()
        assert_throw latex do 
            throw latex 
        end
    end

    ##
    # Method which test the error on a script
    def testerrorScript
        latex = Latex.new("test/script/badScriptTest.cookie", false)
        assert_raises do 
            latex.lex()
        end
    end

    ##
    # Method which test the error "file not specify"
    def testfileNotSpecify
        latex = Latex.new(nil, false)
        latex.lex()
        assert_throw latex do 
            throw latex 
        end
    end

end

