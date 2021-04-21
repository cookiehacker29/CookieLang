require_relative "AstNode"

class Return < AstNode
    def initialize content
        @content = content
    end
    def to_s
        result = "return : content = #{@content}"
        result
    end
end