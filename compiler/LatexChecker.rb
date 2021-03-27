module LatexChecker
    
    class SpecialLatex
        def self.check(data, tokens, pos)
            tokenModel = Struct.new(:id,:value,:pos)
            success = true
            case data
                when /\A\n/
                    tokens << tokenModel.new(:jump,$&,  pos) 
                when /\A\s/
                    tokens << tokenModel.new(:space,$&,  pos)
                when /\A\,/
                    tokens << tokenModel.new(:sep, $&, pos)
                else
                    success = false
            end
            [success,$&]
        end
    end

    class CookingLatex
        def self.check(data, tokens, pos)
            tokenModel = Struct.new(:id,:value,:pos)
            success = true
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
                    success = false
            end
            [success,$&]
        end
    end

    class ConditionLatex
        def self.check(data, tokens, pos)
            tokenModel = Struct.new(:id,:value,:pos)
            success = true
            case data
                when /\Aif/
                    tokens << tokenModel.new(:if,$&,  pos)
                when /\Aelif/
                    tokens << tokenModel.new(:elif,$&,  pos)
                when /\Aelse/
                    tokens << tokenModel.new(:else,$&,  pos)
                else
                    success = false
            end
            [success,$&]
        end
    end

    class LoopLatex
        def self.check(data, tokens, pos)
            tokenModel = Struct.new(:id,:value,:pos)
            success = true
            case data
                when /\Afor/
                    tokens << tokenModel.new(:for,$&,  pos)
                when /\Awhile/
                    tokens << tokenModel.new(:while,$&,  pos)
                else
                    success = false
            end
            [success,$&]
        end
    end

    class KeywordLatex
        def self.check(data, tokens, pos)
            tokenModel = Struct.new(:id,:value,:pos)
            success = true
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
                    success = false
            end
            [success,$&]
        end
    end

    class ValueLatex
        def self.check(data, tokens, pos)
            tokenModel = Struct.new(:id,:value,:pos)
            success = true
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
                    success = false
            end
            [success,$&]
        end
    end

    class ArithmeticOperatorLatex
        def self.check(data, tokens, pos)
            tokenModel = Struct.new(:id,:value,:pos)
            success = true
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
                    success = false
            end
            [success,$&]
        end
    end

    class ConditionSymbolLatex
        def self.check(data, tokens, pos)
            tokenModel = Struct.new(:id,:value,:pos)
            success = true
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
                    success = false
            end
            [success,$&]
        end
    end

    class SymbolLatex
        def self.check(data, tokens, pos)
            tokenModel = Struct.new(:id,:value,:pos)
            success = true
            case data
                when /\A\=/
                    tokens << tokenModel.new(:equal,$&,  pos)
                when /\A\(/
                    tokens << tokenModel.new(:openpar,$&,  pos)
                when /\A\)/
                    tokens << tokenModel.new(:closepar,$&,  pos)
                else
                    success = false
            end
            [success,$&]
        end
    end

end