##
# This module allow to make lexical checking
#
# * Author : Erwan AUBRY (cookiehacker)
# * School : ENSTA-Bretagne
# * Version : 1.0
module LatexChecker
    
    ##
    # Class allow to verify if the word an special character
    class SpecialLatex
        ##
        # Function allow to check if a data correspond to lexical type
        #
        # ==== Arguments
        #
        # * +data+ - (String) The data to check.
        # * +tokens+ - (Token) The tokens of the cookie script.
        # * +pos+ - (Integer) The position in the script.
        # * +tokenModel+ - (Token[]) The structure of one token.
        #
        # ==== Result
        #
        # * +special+ - (Bool) The value if the data is a special character or not
        # * +word+ - (String) The corresponding word. 
        def self.check(data, tokens, pos, tokenModel)
            special = true
            case data
                when /\A\n/
                    tokens << tokenModel.new(:jump,$&,  pos) 
                when /\A\s/
                    tokens << tokenModel.new(:space,$&,  pos)
                when /\A\,/
                    tokens << tokenModel.new(:sep, $&, pos)
                else
                    special = false
            end
            [special,$&]
        end
    end

    ##
    # Class allow to verify if the word an initialization of variable
    class CookingLatex
        ##
        # Function allow to check if a data correspond to lexical type
        #
        # ==== Arguments
        #
        # * +data+ - (String) The data to check.
        # * +tokens+ - (Token) The tokens of the cookie script.
        # * +pos+ - (Integer) The position in the script.
        # * +tokenModel+ - (Token[]) The structure of one token.
        #
        # ==== Result
        #
        # * +cooking+ - (Bool) The value if the data is an initialization of variable or not
        # * +word+ - (String) The corresponding word. 
        def self.check(data, tokens, pos, tokenModel)
            cooking = true
            case data
                when /\Acookint/
                    tokens << tokenModel.new(:cookint,$&,  pos)
                when /\Acookstring/
                    tokens << tokenModel.new(:cookstring,$&,  pos)
                when /\Acookchar/
                    tokens << tokenModel.new(:cookchar,$&,  pos)
                when /\Acookfloat/
                    tokens << tokenModel.new(:cookfloat,$&,  pos)
                when /\Acookdouble/
                    tokens << tokenModel.new(:cookdouble,$&,  pos)
                when /\Acookbool/
                    tokens << tokenModel.new(:cookbool,$&,  pos)
                else
                    cooking = false
            end
            [cooking,$&]
        end
    end

    ##
    # Class allow to verify if the word a condition
    class ConditionLatex
        ##
        # Function allow to check if a data correspond to lexical type
        #
        # ==== Arguments
        #
        # * +data+ - (String) The data to check.
        # * +tokens+ - (Token) The tokens of the cookie script.
        # * +pos+ - (Integer) The position in the script.
        # * +tokenModel+ - (Token[]) The structure of one token.
        #
        # ==== Result
        #
        # * +condition+ - (Bool) The value if the data is a condition or not
        # * +word+ - (String) The corresponding word. 
        def self.check(data, tokens, pos, tokenModel)
            condition = true
            case data
                when /\Aif/
                    tokens << tokenModel.new(:if,$&,  pos)
                when /\Aelif/
                    tokens << tokenModel.new(:elif,$&,  pos)
                when /\Aelse/
                    tokens << tokenModel.new(:else,$&,  pos)
                else
                    condition = false
            end
            [condition,$&]
        end
    end

    ##
    # Class allow to verify if the word a loop
    class LoopLatex
        ##
        # Function allow to check if a data correspond to lexical type
        #
        # ==== Arguments
        #
        # * +data+ - (String) The data to check.
        # * +tokens+ - (Token) The tokens of the cookie script.
        # * +pos+ - (Integer) The position in the script.
        # * +tokenModel+ - (Token[]) The structure of one token.
        #
        # ==== Result
        #
        # * +isloop+ - (Bool) The value if the data is a loop or not
        # * +word+ - (String) The corresponding word. 
        def self.check(data, tokens, pos, tokenModel)
            isloop = true
            case data
                when /\Afor/
                    tokens << tokenModel.new(:for,$&,  pos)
                when /\Awhile/
                    tokens << tokenModel.new(:while,$&,  pos)
                else
                    isloop = false
            end
            [isloop,$&]
        end
    end

    ##
    # Class allow to verify if the word a keyword
    class KeywordLatex
        ##
        # Function allow to check if a data correspond to lexical type
        #
        # ==== Arguments
        #
        # * +data+ - (String) The data to check.
        # * +tokens+ - (Token) The tokens of the cookie script.
        # * +pos+ - (Integer) The position in the script.
        # * +tokenModel+ - (Token[]) The structure of one token.
        #
        # ==== Result
        #
        # * +keyword+ - (Bool) The value if the data is a keyword or not
        # * +word+ - (String) The corresponding word. 
        def self.check(data, tokens, pos, tokenModel)
            keyword = true
            case data
                # EXIT
                when /\Acookiegoawayandsay/
                    tokens << tokenModel.new(:cookiegoawayandsay,$&,  pos)
                
                # RETURN
                when /\Aeat/
                    tokens << tokenModel.new(:eat,$&,  pos)
                
                # PRINT
                when /\Ashow/
                    tokens << tokenModel.new(:show,$&,  pos)

                # END
                when /\Aend/
                    tokens << tokenModel.new(:end, $&, pos)

                # FONCTION
                when /\Acookiedough/
                    tokens << tokenModel.new(:cookiedough, $&, pos)
                
                else
                    keyword = false
            end
            [keyword,$&]
        end
    end

    ##
    # Class allow to verify if the word a value
    class ValueLatex
        ##
        # Function allow to check if a data correspond to lexical type
        #
        # ==== Arguments
        #
        # * +data+ - (String) The data to check.
        # * +tokens+ - (Token) The tokens of the cookie script.
        # * +pos+ - (Integer) The position in the script.
        # * +tokenModel+ - (Token[]) The structure of one token.
        #
        # ==== Result
        #
        # * +value+ - (Bool) The value if the data is a value or not
        # * +word+ - (String) The corresponding word. 
        def self.check(data, tokens, pos, tokenModel)
            value = true
            case data
                when /\A\'[a-zA-Z]\'/
                    tokens << tokenModel.new(:char, $&, pos)
                when /\A".*"/
                    tokens << tokenModel.new(:string,$&,  pos)
                when /\A[0|1]b/
                    tokens << tokenModel.new(:bool,$&,  pos)
                when /\A(\-)?([0-9]+)(\.)([0-9]+)((e)(\-)?[0-9]+)?f/
                    tokens << tokenModel.new(:float,$&,  pos)
                when /\A(\-)?([0-9]+)(\.)([0-9]+)((e)(\-)?[0-9]+)?/
                    tokens << tokenModel.new(:double,$&,  pos)
                when /\A[0-9]+/
                    tokens << tokenModel.new(:int,$&,  pos)
                when /\A[a-zA-Z]+/
                    tokens << tokenModel.new(:id,$&,  pos)
                else
                    value = false
            end
            [value,$&]
        end
    end

    ##
    # Class allow to verify if the word an arithmetic operator advanced
    class ArithmeticOperatorAdvancedLatex
        ##
        # Function allow to check if a data correspond to lexical type
        #
        # ==== Arguments
        #
        # * +data+ - (String) The data to check.
        # * +tokens+ - (Token) The tokens of the cookie script.
        # * +pos+ - (Integer) The position in the script.
        # * +tokenModel+ - (Token[]) The structure of one token.
        #
        # ==== Result
        #
        # * +aoa+ - (Bool) The value if the data is an arithmetic operator advanced or not
        # * +word+ - (String) The corresponding word. 
        def self.check(data, tokens, pos, tokenModel)
            aoa = true
            case data
                when /\A\+\+/
                    tokens << tokenModel.new(:incr,$&,  pos)
                when /\A\-\-/
                    tokens << tokenModel.new(:decr,$&,  pos)
                when /\A\+\=/
                    tokens << tokenModel.new(:addequal,$&, pos)
                when /\A\-\=/
                    tokens << tokenModel.new(:subequal,$&, pos)
                when /\A\/\=/
                    tokens << tokenModel.new(:divequal,$&, pos)
                when /\A\*\=/
                    tokens << tokenModel.new(:multequal,$&, pos)
                else
                    aoa = false
            end
            [aoa,$&]
        end
    end

    ##
    # Class allow to verify if the word an arithmetic operator
    class ArithmeticOperatorLatex
        ##
        # Function allow to check if a data correspond to lexical type
        #
        # ==== Arguments
        #
        # * +data+ - (String) The data to check.
        # * +tokens+ - (Token) The tokens of the cookie script.
        # * +pos+ - (Integer) The position in the script.
        # * +tokenModel+ - (Token[]) The structure of one token.
        #
        # ==== Result
        #
        # * +ao+ - (Bool) The value if the data is an arithmetic operator or not
        # * +word+ - (String) The corresponding word. 
        def self.check(data, tokens, pos, tokenModel)
            ao = true
            case data
                when /\A\<\</
                    tokens << tokenModel.new(:bls,$&, pos)
                when /\A\>\>/
                    tokens << tokenModel.new(:brs,$&, pos)
                when /\A\+/
                    tokens << tokenModel.new(:plus,$&,  pos)
                when /\A\-/
                    tokens << tokenModel.new(:sub,$&,  pos)
                when /\A\*/
                    tokens << tokenModel.new(:mult,$&,  pos)
                when /\A\//
                    tokens << tokenModel.new(:div,$&,  pos)
                else
                    ao = false
            end
            [ao,$&]
        end
    end

    
    ##
    # Class allow to verify if the word a condition symbol
    class ConditionSymbolLatex
        ##
        # Function allow to check if a data correspond to lexical type
        #
        # ==== Arguments
        #
        # * +data+ - (String) The data to check.
        # * +tokens+ - (Token) The tokens of the cookie script.
        # * +pos+ - (Integer) The position in the script.
        # * +tokenModel+ - (Token[]) The structure of one token.
        #
        # ==== Result
        #
        # * +co+ - (Bool) The value if the data is a condition symbol or not
        # * +word+ - (String) The corresponding word. 
        def self.check(data, tokens, pos, tokenModel)
            co = true
            case data
                when /\A\>\=/
                    tokens << tokenModel.new(:greaterandequal,$&,  pos)
                when /\A\<\=/
                    tokens << tokenModel.new(:lowerandequal,$&,  pos)
                when /\A\</
                    tokens << tokenModel.new(:lower,$&,  pos)
                when /\A\>/
                    tokens << tokenModel.new(:greater,$&,  pos)
                when /\A\=\=/
                    tokens << tokenModel.new(:isequal,$&,  pos)
                when /\A\!\=/
                    tokens << tokenModel.new(:notequal,$&,  pos)
                else
                    co = false
            end
            [co,$&]
        end
    end

    ##
    # Class allow to verify if the word a simple symbol
    class SymbolLatex
        ##
        # Function allow to check if a data correspond to lexical type
        #
        # ==== Arguments
        #
        # * +data+ - (String) The data to check.
        # * +tokens+ - (Token) The tokens of the cookie script.
        # * +pos+ - (Integer) The position in the script.
        # * +tokenModel+ - (Token[]) The structure of one token.
        #
        # ==== Result
        #
        # * +symbol+ - (Bool) The value if the data is a simple symbol or not
        # * +word+ - (String) The corresponding word. 
        def self.check(data, tokens, pos, tokenModel)
            symbol = true
            case data
                when /\A\=/
                    tokens << tokenModel.new(:equal,$&,  pos)
                when /\A\(/
                    tokens << tokenModel.new(:openpar,$&,  pos)
                when /\A\)/
                    tokens << tokenModel.new(:closepar,$&,  pos)
                else
                    symbol = false
            end
            [symbol,$&]
        end
    end

end