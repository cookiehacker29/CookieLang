module Initialization
    class Cookint
        def initialize(ident,value)
            @ident = ident
            @value = value
        end

        def to_s
            result = "cookint : ident = #{@ident} | value = #{@value}"
            result
        end
    end

    class Cookfloat
        def initialize(ident,value)
            @ident = ident
            @value = value
        end

        def to_s
            result = "cookfloat : ident = #{@ident} | value = #{@value}"
            result
        end
    end

    class Cookdouble
        def initialize(ident,value)
            @ident = ident
            @value = value
        end

        def to_s
            result = "cookdouble : ident = #{@ident} | value = #{@value}"
            result
        end
    end

    class Cookbool
        def initialize(ident,value)
            @ident = ident
            @value = value
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

        def to_s
            result = "cookstring : ident = #{@ident} | value = #{@value}"
            result
        end
    end
end