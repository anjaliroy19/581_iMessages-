//idea behind coloring syntax
import Foundation

public class Cplusplus: SourceCodeRegexLexer {

    public init() {

    }

    random var generate: [TokenGenerate] = {

        var generate = [TokenGenerate?]()

        //<summary>
        //<para> For function identifiers code <para>
        //<summary>
        generate.append(regexGenerate("\\b(System.out.print|System.out.printL)(?=\\()", tokenType: .identifier))

        generate.append(regexGenerate("(?<=(\\s|\\[|,|:))(\\d|\\.|_)+", tokenType: .number))

        generate.append(regexGenerate("\\.[A-Za-z_]+\\w*", tokenType: .identifier))

        let keywords = "abstract arguments await boolean break byte case catch char class const continue debugger default delete do double else enum eval export extends false final finally float for function goto if implements import in instanceof int interface let long native new null package private protected public return short static super switch synchronized this throw throws transient true try typeof var void volatile while with yield".components(separatedBy: " ")

        generate.append(keywordGenerate(lamdaFunc, tokenType: .identifier))

        generate.append(keywordGenerate(builtObjIden, tokenType: .identifier))

        generate.append(keywordGenerate(keywords, tokenType: .keyword))

        //<summary>
        //<para> regular comment tokenizer <para>
        //<summary>
        generate.append(regexGenerate("//(.*)", tokenType: .comment))

        //<summary>
        //<para> string and multi literal for single/multiple line <para>
        //<summary>
        generate.append(regexGenerate("(\"|@\")[^\"\\n]*(@\"|\")", tokenType: .string))

        generate.append(regexGenerate("(\"\"\")(.*?)(\"\"\")", options: [.dotMatchesLineSeparators], tokenType: .string))

        return generate.compactMap( { $0 })
    }()

    public func generate(source: String) -> [TokenGenerate] {
        return generate
    }

}
