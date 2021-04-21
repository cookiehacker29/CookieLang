require_relative "AstNode"

module Initialization
    class Cookint < AstNode
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
            result = "cookint : ident = #{@ident} | value = #{@value}"
            result
        end
    end

    class Cookdouble < AstNode
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
            result = "cookdouble : ident = #{@ident} | value = #{@value}"
            result
        end
    end

    class Cookbool < AstNode
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

    class Cookchar < AstNode
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

    class Cookstring < AstNode
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