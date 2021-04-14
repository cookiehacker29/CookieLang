module Expression
    class Equation
        attr_accessor :bin
        def initialize bin
            @bin=bin
        end
        def to_s
            result = ""
            current = @bin
            while current.is_a?(Binary)
                result+="#{current.lhs}#{current.op}"
                current=current.rhs
            end
            result+="#{current}"
            

            result
        end
    end

    class Binary
        attr_accessor :lhs,:op,:rhs
        def initialize lhs,op,rhs
            @lhs,@rhs,@op=lhs,rhs,op
        end
        def to_s
            result = "{BINARY = #{lhs}#{op}#{rhs}}"
        end
    end

    class Id
        attr_accessor :str
        def initialize str
            @str = str
        end
        def to_s
            @str
        end
    end

    class Op
        attr_accessor :symb_str
        def initialize symb_str
            @symb_str = symb_str
        end
        def to_s
            @symb_str
        end
    end
end