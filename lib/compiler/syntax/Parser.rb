require_relative 'DesignUnit'
require_relative 'Initialization'
require_relative 'If'

##
# Class allow to parsing a cookieLang script
#
# * Author : Erwan AUBRY (cookiehacker)
# * School : ENSTA-Bretagne
# * Version : 1.0
class Parser

    BOOLEANSYMBOL = [
        :greaterandequal, 
        :lowerandequal, 
        :lower, 
        :greater, 
        :isequal, 
        :notequal
    ]

    BRACE = [
        :closepar,
        :openpar
    ]

    ARITHMSYMBOL = [
        :bls,
        :brs,
        :plus,
        :sub,
        :mult,
        :div
    ]

    ACCEPTBOOLEAN = [
        :id,
        :bool
    ]

    ACCEPTARITHM = [
        :bool,
        :double,
        :int,
        :id
    ]

    ##
    # Function constructor to create an instance of Parser class.
    #
    # ==== Attributes
    #
    # * +tokens+ - The tokens of the cookie script.
    def initialize(tokens)
        @tokens = tokens
        @du = []
        @stringToEval = ""
        @bcounter = 0
        @Equation = Struct.new(:bin)
        @Binary = Struct.new(:lhs,:op,:rhs)
        @Id = Struct.new(:str)
        @Op = Struct.new(:symb_str)
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
            parse_main_key()
            
        end
    end

    def parse_main_key
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
            when :id
                acceptIt
                parse_arithmetic_op()
            when :while
                acceptIt
                parse_while()
            when :show
                acceptIt
                parse_expression()
            when :cookiegoawayandsay
                acceptIt
                parse_cookiegoawayandsay()
            when :return
                acceptIt
                parse_return()
            else
                raise "#{showNext.value} undefined!"
                abort
        end
    end

    def parse_cookint
        case showNext.id
            when :id
                value = showNext.value
                if findLastInit(value) != nil
                    raise "The variable name '#{value}' is already defined"
                    abort
                end
                acceptIt
                if showNext.id == :equal                    
                    acceptIt
                    parse_arithmetic_op()
                    @du << Initialization::Cookint.new(value, @stringToEval)
                    @stringToEval = ""
                else
                    @du << Initialization::Cookint.new(value, 0)
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
                if findLastInit(value) != nil
                    raise "The variable name '#{value}' is already defined"
                    abort
                end
                acceptIt
                if showNext.id == :equal                    
                    acceptIt
                    parse_arithmetic_op()
                    @du << Initialization::Cookint.new(value, @stringToEval)
                    @stringToEval = ""
                else
                    @du << Initialization::Cookdouble.new(showNext.value, 0.0)
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
                if findLastInit(value) != nil
                    raise "The variable name '#{value}' is already defined"
                    abort
                end
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
                    @du << Initialization::Cookbool.new(showNext.value, '0b')
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
                if findLastInit(value) != nil
                    raise "The variable name '#{value}' is already defined"
                    abort
                end
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
                    @du << Initialization::Cookchar.new(showNext.value, '')
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
                if findLastInit(value) != nil
                    raise "The variable name '#{value}' is already defined"
                    abort
                end
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
                    @du << Initialization::Cookstring.new(showNext.value, "")
                end
            else
                raise "The initialisation of a value must be have a identifiant !"
                abort
        end 
    end

    def parse_arithmetic_op
        if ACCEPTARITHM.include? showNext.id
            if showNext.id == :id
                initObject = findLastInit(showNext.value)
                if initObject == nil
                    raise "The variable #{showNext.value} is not defined !"
                    abort
                end
            end
            if lookahead(1) != nil
                if ARITHMSYMBOL.include? lookahead(1).id
                    acceptIt
                    parse_arithmetic_op()
                elsif ACCEPTARITHM.include? lookahead(1).id
                    raise "You must have nothing or arithmetic symbol after a value or an ID"
                    abort
                else
                    acceptIt
                end
            else
                acceptIt
            end  
        elsif ARITHMSYMBOL.include? showNext.id
            value = lookahead(1).id
            if ACCEPTARITHM.include? value
                acceptIt
                parse_arithmetic_op()
            else 
                raise "You must have an ID or arithmetic value after #{showNext.value}"
                abort
            end
        end
    end

    def parse_boolean_op
        if ACCEPTBOOLEAN.include? showNext.id
            if showNext.id == :id
                initObject = findLastInit(showNext.value)
                if initObject == nil
                    raise "The variable #{showNext.value} is not defined !"
                    abort
                end                
            end
            if lookahead(1) != nil
                if BOOLEANSYMBOL.include? lookahead(1).id
                    acceptIt
                    parse_boolean_op()
                elsif ACCEPTBOOLEAN.include? lookahead(1).id
                    raise "You must have nothing or boolean symbol after a boolean value or an ID"
                    abort
                else
                    acceptIt
                end
            else
                acceptIt
            end
        elsif BOOLEANSYMBOL.include? showNext.id
            value = lookahead(1).id
            if ACCEPTBOOLEAN.include? value
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
        parse_main_key()
        if showNext == nil || showNext.id != :end
            raise "All if must finished by end"
            abort
        end
        acceptIt
    end

    def parse_while
        parse_boolean_op()
        parse_main_key()
        if showNext == nil || showNext.id != :end
            raise "All while must finished by end"
            abort
        end
        acceptIt
    end

    def parse_show
        parse_arithmetic_op()
    end

    def parse_cookiegoawayandsay
        if showNext.id == :int
            acceptIt
        else
            raise "cookiegoawayandsay take only int !"
            abort
        end
    end

    def parse_return
        parse_arithmetic_op()
    end

    def findLastInit ident
        @du.each do |d|
            if d.getIdent() == ident
                return d
            end
        end
        return nil
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