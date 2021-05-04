class Return < AstNode
    attr_accessor :content
    def initialize content
        @content = content
    end
    def to_s
        result = "return : content = #{@content}"
        result
    end
end