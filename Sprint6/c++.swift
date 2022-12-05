//idea behind coloring syntax

//Currently we tried running the lexer files on python and are running into multiple errors that we do not understand.
//However, we are going to go try to talk to our 665 professor about these errors and see if he can lead us in the correct direction.
//If this does not work and even if it does I believe we will try to look into other ways to produce a highlighter in the next sprint.
//We are planning on writing a short report as to why this will not work/ why we can’t get it to work and find a different solution
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
