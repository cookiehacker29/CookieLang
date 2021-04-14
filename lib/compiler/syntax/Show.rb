class Show
    def initialize(content)
        @content = content
    end

    def to_s
        result = "SHOW : content = #{@content}"
        result
    end
end