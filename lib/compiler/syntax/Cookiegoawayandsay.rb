class Cookiegoawayandsay < AstNode
    attr_accessor :value
    def initialize(value)
        @value = value
    end
    def to_s
        result = "Cookiegoawayandsay : #{@value}"
        result
    end
end