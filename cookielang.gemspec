Gem::Specification.new do |s|
    s.name          = "cookielang"
    s.version       = "1.0.0"
    s.summary       = "CookieLang"
    s.description   = "Compiler of CookieLang"
    s.authors       = ["Erwan AUBRY"]
    s.email         = "erwan.aubry@ensta-bretagne.org"
    s.files         = [
                        "lib/cookielang.rb", 
                        "lib/compiler/lexical/Latex.rb", 
                        "lib/compiler/syntax/Parser.rb",
                        "lib/compiler/syntax/Initialization.rb",
                        "lib/compiler/syntax/DesignUnit.rb",
                        "lib/compiler/syntax/If.rb"
                    ]
    s.homepage      = "https://github.com/erwanaubry/CookieLang"
    s.license       = "MIT"
end