require_relative 'DesignUnit'
require_relative 'Initialization'

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
        @du = DesignUnit.new()
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

    def showNext
        @tokens.first
    end
    
    def lookahead(n=2)
        @tokens[n] if @tokens.any?
    end

    def parse
        begin
            @tokens = clear_code()
            puts @tokens
            design_unit()
            puts @du
        rescue Exception => e
            puts "PARSING ERROR : #{e}"
            puts "in cookieLang source at position #{showNext.pos}"
            #puts e.backtrace
            abort
        end
    end

    def design_unit
        while @tokens.any?
            pars_main_key()
        end
    end

    def pars_main_key
        case showNext.id
            when :cookint
                acceptIt
                parse_cookint()
            when :cookdouble
                acceptIt
                parse_cookdouble()
            when :cookbool
                acceptIt
                parse_cookbool()
            when :cookfloat
                acceptIt
                parse_cookfloat()
            when :cookstring
                acceptIt
                parse_cookstring()
            when :cookchar
                acceptIt
                parse_cookchar()
            when :if
                acceptIt
                parse_if()
            else
                raise "#{showNext.value} undefined!"
                abort
        end
    end

    def parse_cookint
        case showNext.id
            when :id
                value = showNext.value
                acceptIt
                if showNext.id == :equal                    
                    acceptIt
                    if showNext.id == :int
                        @du << Initialization::Cookint.new(value, showNext.value)
                        acceptIt
                    else
                        raise "Type error ! The value of cookint type, must be Integer !"
                        abort
                    end
                else
                    @du << Initialization::Cookint.new(showNext.value, 0)
                    acceptIt
                end
            else
                raise "The initialisation of a value must be have a identifiant !"
                abort
        end 
    end

    def parse_cookfloat
        case showNext.id
            when :id
                value = showNext.value
                acceptIt
                if showNext.id == :equal                    
                    acceptIt
                    if showNext.id == :float
                        @du << Initialization::Cookfloat.new(value, showNext.value)
                        acceptIt
                    else
                        raise "Type error ! The value of cookfloat type, must be Float !"
                        abort
                    end
                else
                    @du << Initialization::Cookfloat.new(showNext.value, 0)
                    acceptIt
                end
            else
                raise "The initialisation of a value must be have a identifiant !"
                abort
        end 
    end

    def parse_cookdouble
        case showNext.id
            when :id
                value = showNext.value
                acceptIt
                if showNext.id == :equal                    
                    acceptIt
                    if showNext.id == :double
                        @du << Initialization::Cookdouble.new(value, showNext.value)
                        acceptIt
                    else
                        raise "Type error ! The value of cookdouble type, must be Double !"
                        abort
                    end
                else
                    @du << Initialization::Cookdouble.new(showNext.value, 0)
                    acceptIt
                end
            else
                raise "The initialisation of a value must be have a identifiant !"
                abort
        end 
    end

    def parse_cookbool
        case showNext.id
            when :id
                value = showNext.value
                acceptIt
                if showNext.id == :equal                    
                    acceptIt
                    if showNext.id == :bool
                        @du << Initialization::Cookbool.new(value, showNext.value)
                        acceptIt
                    else
                        raise "Type error ! The value of cookbool type, must be Bool !"
                        abort
                    end
                else
                    @du << Initialization::Cookbool.new(showNext.value, 0)
                    acceptIt
                end
            else
                raise "The initialisation of a value must be have a identifiant !"
                abort
        end 
    end

    def parse_cookchar
        case showNext.id
            when :id
                value = showNext.value
                acceptIt
                if showNext.id == :equal                    
                    acceptIt
                    if showNext.id == :char
                        @du << Initialization::Cookchar.new(value, showNext.value)
                        acceptIt
                    else
                        raise "Type error ! The value of cookchar type, must be Char !"
                        abort
                    end
                else
                    @du << Initialization::Cookchar.new(showNext.value, 0)
                    acceptIt
                end
            else
                raise "The initialisation of a value must be have a identifiant !"
                abort
        end 
    end

    def parse_cookstring
        case showNext.id
            when :id
                value = showNext.value
                acceptIt
                if showNext.id == :equal                    
                    acceptIt
                    if showNext.id == :string
                        @du << Initialization::Cookstring.new(value, showNext.value)
                        acceptIt
                    else
                        raise "Type error ! The value of cookstring type, must be String !"
                        abort
                    end
                else
                    @du << Initialization::Cookstring.new(showNext.value, 0)
                    acceptIt
                end
            else
                raise "The initialisation of a value must be have a identifiant !"
                abort
        end 
    end

    def parse_boolean_op
    
        if [:id,:bool].include? showNext.id
            if lookahead(1) != nil
                if [:greaterandequal, :lowerandequal, :lower, :greater, :isequal, :notequal].include? lookahead(1).id
                    acceptIt
                    parse_boolean_op()
                elsif [:id,:bool].include? lookahead(1).id
                    raise "You must have nothing or boolean symbol after a boolean value or an ID"
                    abort
                else
                    acceptIt
                end
            else
                acceptIt
            end
        elsif [:greaterandequal, :lowerandequal, :lower, :greater, :isequal, :notequal].include? showNext.id
            value = lookahead(1).id
            if [:id, :bool].include? value
                acceptIt
                parse_boolean_op()
            else 
                raise "You must have an ID or boolean value after #{showNext.value}"
                abort
            end
        end

    end

    def parse_if
        parse_boolean_op()
        puts "\n\n"
        puts @tokens
        pars_main_key()
        if showNext == nil || showNext.id != :end
            raise "All if must finished by end"
            abort
        end
        acceptIt
    end

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