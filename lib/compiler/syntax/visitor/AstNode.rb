class AstNode
    def accept(visitor, arg=nil)
        name = self.class.name.split(/::/).last
        visitor.send("visit#{name}".to_sym, self, arg)
    end
end