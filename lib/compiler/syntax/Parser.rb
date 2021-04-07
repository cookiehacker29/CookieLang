##
# Class allow to parsing a cookieLang script
#
# * Author : Erwan AUBRY (cookiehacker)
# * School : ENSTA-Bretagne
# * Version : 1.0
class Parser
    ##
    # Function constructor to create an instance of Parser class.
    #
    # ==== Attributes
    #
    # * +tokens+ - The tokens of the cookie script.
    def initialize(tokens)
        @tokens = tokens
    end

    def acceptIt
        @tokens.shift
    end

    def maybe kind
        return acceptIt if showNext.is? kind
    end

    def expect kind
        if((actual=@tokens.shift).kind)!=kind
            puts "Error : Received '#{actual.val}' at #{actual.pos}"
            show_line(actual.pos)
            raise "Expecting '#{kind}'."
        end
        return actual
    end

    def showNext(n=1)
        @tokens[n-1] if @tokens.any?
    end

    def lookahead(n=2)
        @tokens[n] if @tokens.any?
    end

    def parse
        begin
            @tokens = clear_code()
            #ast = design_unit()
        rescue Exception => e
            puts "PARSING ERROR : #{e}"
            puts "in cookieLang source at position #{showNext.pos}"
            puts e.backtrace
            abort
        end
    end

    # def design_unit
    #     du = ""
    #     while @tokens.any?
    #         case showNext().id
    #             when :cookint
    #                 du = "cookint"
    #             end
    #         end
    #     end
    # end

    def clear_code
        tmp = []
        i = 0
        j = 0

        @tokens.each do |t|    
            if [:comment, :jump, :space].include? t.id 
                tmp.append(i)
            end
            i +=1
        end

        tmp.each do |v|
            indice = v-j
            @tokens.delete_at(indice)
            j+=1
        end

        @tokens
    end
end