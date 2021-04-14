require_relative 'DesignUnit'
require_relative 'Initialization'
require_relative 'If'
require_relative 'While'
require_relative 'Expression'
require_relative 'Show'
require_relative 'Return'

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
    def initialize(tokens, verbose)
        @tokens = tokens
        @verbose = verbose
        @du = []
        @stringToEval = ""
        @bcounter = 0
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
            if @verbose
                puts @du
            end
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

    def parse_main_key(lst = @du)
        case showNext.id
            when :cookint
                acceptIt
                parse_cookint(lst)
            when :cookdouble
                acceptIt
                parse_cookdouble(lst)
            when :cookbool
                acceptIt
                parse_cookbool(lst)
            when :cookfloat
                acceptIt
                parse_cookfloat(lst)
            when :cookstring
                acceptIt
                parse_cookstring(lst)
            when :cookchar
                acceptIt
                parse_cookchar(lst)
            when :if
                acceptIt
                parse_if(lst)
            when :id
                parse_equation(lst)
            when :while
                acceptIt
                parse_while(lst)
            when :show
                acceptIt
                parse_show(lst)
            when :cookiegoawayandsay
                acceptIt
                parse_cookiegoawayandsay(lst)
            when :return
                acceptIt
                parse_return(lst)
            when :jump
                acceptIt
            else
                raise "#{showNext.value} undefined!"
                abort
        end
    end

    def parse_cookint lst
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
                    lst << Initialization::Cookint.new(value, parse_arithmetic_op())
                else
                    lst << Initialization::Cookint.new(value, 0)
                end
            else
                raise "The initialisation of a value must be have a identifiant !"
                abort
        end 
        if showNext.id = :jump 
            acceptIt
        end
    end

    def parse_cookdouble lst
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
                    @du << Initialization::Cookint.new(value, parse_arithmetic_op())
                else
                    @du << Initialization::Cookdouble.new(showNext.value, 0.0)
                end
            else
                raise "The initialisation of a value must be have a identifiant !"
                abort
        end 
        if showNext.id = :jump 
            acceptIt
        end
    end

    def parse_cookbool lst
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
        if showNext.id = :jump 
            acceptIt
        end
    end

    def parse_cookchar lst
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
        if showNext.id = :jump 
            acceptIt
        end
    end

    def parse_cookstring lst
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
        if showNext.id = :jump 
            acceptIt
        end
    end

    def parse_equation lst
        id = showNext.value
        acceptIt
        if showNext.id == :equal
            acceptIt
            newbin = Expression::Binary.new(nil,nil,nil)
            eq = Expression::Equation.new(id,newbin)
            begin
                lst << parse_arithmetic_op(eq,newbin)
            rescue
                begin
                    lst << parse_boolean_op(eq,newbin)
                rescue
                    raise "The operation aren't arithmetic or boolean"
                end
            end
            acceptIt
        end
    end

    def parse_arithmetic_op(eq=nil, newbin=nil)
        if eq==nil
            newbin = Expression::Binary.new(nil,nil,nil)
            eq = Expression::Equation.new(nil,newbin)
        end
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
                    newbin.lhs = Expression::Id.new(showNext.value)
                    acceptIt
                    parse_arithmetic_op(eq, newbin)
                elsif ACCEPTARITHM.include? lookahead(1).id
                    raise "You must have nothing or arithmetic symbol after a value or an ID"
                    abort
                else
                    newbin.rhs = Expression::Id.new(showNext.value)
                    acceptIt
                end
            else
                newbin.lhs = Expression::Id.new(showNext.value)
                acceptIt
            end  
        elsif ARITHMSYMBOL.include? showNext.id
            value = lookahead(1).id
            if ACCEPTARITHM.include? value
                newbin.op = Expression::Op.new(showNext.value)
                if ARITHMSYMBOL.include? lookahead(2).id
                    nb = Expression::Binary.new(nil,nil,nil)
                    newbin.rhs = nb 
                    acceptIt
                    parse_arithmetic_op(eq, nb)    
                else
                    acceptIt
                    parse_arithmetic_op(eq, newbin)              
                end
                
            else 
                raise "You must have an ID or arithmetic value after #{showNext.value}"
                abort
            end
        end
        eq
    end

    def parse_boolean_op(eq=nil, newbin=nil)
        if eq==nil
            newbin = Expression::Binary.new(nil,nil,nil)
            eq = Expression::Equation.new(nil,newbin)
        end
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
                    newbin.lhs = Expression::Id.new(showNext.value)
                    acceptIt
                    parse_boolean_op(eq, newbin)
                elsif ACCEPTBOOLEAN.include? lookahead(1).id
                    puts lookahead(1).id
                    puts lookahead(1).value
                    raise "You must have nothing or boolean symbol after a boolean value or an ID"
                    abort
                else
                    newbin.rhs = Expression::Id.new(showNext.value)
                    acceptIt
                end
            else
                newbin.lhs = Expression::Id.new(showNext.value)
                acceptIt
            end
        elsif BOOLEANSYMBOL.include? showNext.id
            value = lookahead(1).id
            if ACCEPTBOOLEAN.include? value
                newbin.op = Expression::Op.new(showNext.value)
                if BOOLEANSYMBOL.include? lookahead(2).id
                    nb = Expression::Binary.new(nil,nil,nil)
                    newbin.rhs = nb 
                    acceptIt
                    parse_boolean_op(eq, nb)    
                else
                    acceptIt
                    parse_boolean_op(eq, newbin)              
                end
            else 
                raise "You must have an ID or boolean value after #{showNext.value}"
                abort
            end
        end
        eq
    end

    def parse_if lst
        cond = parse_boolean_op()
        acceptIt
        content = []
        while showNext.id!=:end
            parse_main_key(content)
        end
        if showNext == nil || showNext.id != :end
            raise "All if must finished by end"
            abort
        end
        lst << If.new(cond,content)
        acceptIt
        acceptIt
    end

    def parse_while lst
        cond = parse_boolean_op()
        acceptIt
        content = []
        while showNext.id!=:end
            parse_main_key(content)
        end
        if showNext == nil || showNext.id != :end
            raise "All while must finished by end"
            abort
        end
        lst << While.new(cond,content)
        acceptIt
        acceptIt
    end

    def parse_show lst
        eq = parse_arithmetic_op()
        lst << Show.new(eq)
    end

    def parse_cookiegoawayandsay lst
        if showNext.id == :int
            acceptIt
        else
            raise "cookiegoawayandsay take only int !"
            abort
        end
    end

    def parse_return lst
        lst << Return.new(parse_arithmetic_op())
    end

    def findLastInit ident
        @du.each do |d|
            if d.getIdent() == ident
                return d
            end
        end
        return nil
    end

    def findLastBinary equation
        current = equation.bin
        while current.lhs.is_a?(Binary) == true
            current = current.lhs
        end
        current
    end

    def clear_code
        tmp = []
        i = 0
        j = 0

        @tokens.each do |t|    
            if [:comment, :space].include? t.id 
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