class Visitor
    def visit ast
        ast.accept(self)
    end

    # FUNCTIONS
    def visitCookiegoawayandsay cookiegoawayandsay
        cookiegoawayandsay.value.accept(self)
    end

    def visitReturn re
        re.content.accept(self)
    end

    def visitShow sh 
        sh.content.accept(self)
    end

    # WHILE
    def visitWhile wh
        wh.condition.accept(self)
        wh.statement.accept(self)
    end

    # IF
    def visitIf ifv
        ifv.condition.accept(self)
        ifv.statement.accept(self)
    end

    # INIT
    def visitCookint cookint
        cookint.ident.accept(self)
        cookint.value.accept(self)
    end

    def visitCookdouble cookdouble
        cookdouble.ident.accept(self)
        cookdouble.value.accept(self)
    end

    def visitCookbool cookbool
        cookbool.ident.accept(self)
        cookbool.value.accept(self)
    end

    def visitCookchar cookchar
        cookchar.ident.accept(self)
        cookchar.value.accept(self)
    end

    def visitCookstring cookstring
        cookstring.ident.accept(self)
        cookstring.value.accept(self)
    end

    # EXPRESSION
    def visitEquation equation
        equation.ident.accept(self)
        equation.bin.accept(self)
    end

    def visitBinary binary
        binary.lhs.accept(self)
        binary.op.accept(self)
        binary.rhs.accept(self)
    end

    def visitId id
        id.str.accept(self)
    end

    def visitOp op
        op.symb_str.accept(self)
    end
end