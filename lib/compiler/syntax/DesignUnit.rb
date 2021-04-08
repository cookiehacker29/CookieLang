class DesignUnit
    def initialize
        @data = []
    end

    def <<(newElement)
        @data.append(newElement)
    end

    def to_s
        result = "Result of parsing !\n"
        @data.each do |d|
            result += "#{d}\n"
        end
        result
    end
end