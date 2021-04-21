require_relative "AstNode"

class Show < AstNode
    def initialize(content)
        @content = content
    end

    def to_s
        result = "show : content = #{@content}"
        result
    end
end