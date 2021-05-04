class While < AstNode
    attr_accessor :condition
    attr_accessor :statement
    def initialize(condition,statement)
        @condition = condition
        @statement = statement
    end

    def to_s()
        result = "while #{@condition}\n"
        @statement.each do |s|
            result+="#{s}\n"
        end
        result+="end"
    end
end