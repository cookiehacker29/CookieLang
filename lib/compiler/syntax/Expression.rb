require_relative "AstNode"

module Expression
    class Equation < AstNode
        attr_accessor :ident,:bin
        def initialize ident,bin
            @bin,@ident=bin,ident
        end
        def to_s
            if @ident != nil
                result = "#{@ident} = "
            else
                result = ""
            end
            current = @bin
            while current.is_a?(Binary)
                result+="#{current.lhs}#{current.op}"
                current=current.rhs
            end
            result+="#{current}"
            result
        end
    end

    class Binary < AstNode
        attr_accessor :lhs,:op,:rhs
        def initialize lhs,op,rhs
            @lhs,@rhs,@op=lhs,rhs,op
        end
        def to_s
            result = "{BINARY = #{lhs}#{op}#{rhs}}"
        end
    end

    class Id < AstNode
        attr_accessor :str
        def initialize str
            @str = str
        end
        def to_s
            @str
        end
    end

    class Op < AstNode
        attr_accessor :symb_str
        def initialize symb_str
            @symb_str = symb_str
        end
        def to_s
            @symb_str
        end
    end
end