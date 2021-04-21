require_relative "AstNode"

class Cookiegoawayandsay < AstNode
    def initialize(value)
        @value = value
    end
    def to_s
        result = "Cookiegoawayandsay : #{@value}"
        result
    end
end