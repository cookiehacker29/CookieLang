class Show < AstNode
    attr_accessor :content
    def initialize(content)
        @content = content
    end

    def to_s
        result = "show : content = #{@content}"
        result
    end
end