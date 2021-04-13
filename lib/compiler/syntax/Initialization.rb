module Initialization
    class Cookint
        def initialize(ident,value)
            @ident = ident
            @value = value
        end

        def getIdent
            @ident
        end

        def getValue
            @value
        end

        def to_s
            result = "cookint : ident = #{@ident} | value = "
            if @value.is_a?(Parser::Equation) == true
                current = @value.bin
                if current.rhs.is_a?(Parser::Binary)
                    while current.is_a?(Parser::Binary)
                        result+="#{current.lhs.str}#{current.op.symb_str}"
                        current=current.rhs
                    end
                else
                    current=current.rhs
                end
                result+="#{current.str}"
            else
                result += "#{@value}"
            end
            result
        end
    end

    class Cookdouble
        def initialize(ident,value)
            @ident = ident
            @value = value
        end

        def getIdent
            @ident
        end

        def getValue
            @value
        end

        def to_s
            result = "cookint : ident = #{@ident} | value = "
            if @value.is_a?(Parser::Equation) == true
                current = @value.bin
                if current.rhs.is_a?(Parser::Binary)
                    while current.is_a?(Parser::Binary)
                        result+="#{current.lhs.str}#{current.op.symb_str}"
                        current=current.rhs
                    end
                else
                    current=current.rhs
                end
                result+="#{current.str}"
            else
                result += "#{@value}"
            end
            result
        end
    end

    class Cookbool
        def initialize(ident,value)
            @ident = ident
            @value = value
        end

        def getIdent
            @ident
        end

        def getValue
            @value
        end

        def to_s
            result = "cookbool : ident = #{@ident} | value = #{@value}"
            result
        end
    end

    class Cookchar
        def initialize(ident,value)
            @ident = ident
            @value = value
        end

        def getIdent
            @ident
        end

        def getValue
            @value
        end

        def to_s
            result = "cookchar : ident = #{@ident} | value = #{@value}"
            result
        end
    end

    class Cookstring
        def initialize(ident,value)
            @ident = ident
            @value = value
        end

        def getIdent
            @ident
        end

        def getValue
            @value
        end

        def to_s
            result = "cookstring : ident = #{@ident} | value = #{@value}"
            result
        end
    end
end