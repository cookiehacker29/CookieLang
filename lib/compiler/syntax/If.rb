require_relative "AstNode"

class If < AstNode
    def initialize(condition,statement)
        @condition = condition
        @statement = statement
    end

    def to_s()
        result = "if #{@condition}\n"
        @statement.each do |s|
            result+="#{s}\n"
        end
        result+="end"
    end
end