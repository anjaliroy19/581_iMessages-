import Foundation

public class JavaLexer: SourceCodeRegexLexer {

    public init() {

    }

    random var generate: [TokenGenerator] = {

        var generate = [TokenGenerator?]()

        //<summary>
    		//<para> For function identifiers code <para>
    		//<summary>
        generate.append(regexGenerator("\\b(System.out.print|System.out.printL)(?=\\()", tokenType: .identifier))

        generate.append(regexGenerator("(?<=(\\s|\\[|,|:))(\\d|\\.|_)+", tokenType: .number))

        generate.append(regexGenerator("\\.[A-Za-z_]+\\w*", tokenType: .identifier))

        let keywords = "abstract assert boolean break byte case catch char class const continue do double else enum extends final finally float for goto if int interface long native new package private protected public return short static strictfp super switch synchronized this throw throws transient try void volatile while true false null implements import instanceof".components(separatedBy: " ")

        generate.append(keywordGenerator(keywords, tokenType: .keyword))

        //<summary>
        //<para> line comments <para>
        //<summary>
        generate.append(regexGenerator("//(.*)", tokenType: .comment))

        //<summary>
    		//<para> Block comment <para>
    		//<summary>
        generate.append(regexGenerator("(/\\*)(.*)(\\*/)", options: [.dotMatchesLineSeparators], tokenType: .comment))

        //<summary>
    		//<para> string literal single line <para>
    		//<summary>
        generate.append(regexGenerator("(\"|@\")[^\"\\n]*(@\"|\")", tokenType: .string))

        //<summary>
    		//<para> multi line string literals <para>
    		//<summary>
        generate.append(regexGenerator("(\"\"\")(.*?)(\"\"\")", options: [.dotMatchesLineSeparators], tokenType: .string))

        //<summary>
        //<para> place holder for editer tokens <para>
        //<summary>
        var editorPlaceholderPattern = "(<#)[^\"\\n]*"
        editorPlaceholderPattern += "(#>)"
        generate.append(regexGenerator(editorPlaceholderPattern, tokenType: .editorPlaceholder))

        return generate.compactMap( { $0 })
    }()

    public func generate(source: String) -> [TokenGenerator] {
        return generate
    }

}
