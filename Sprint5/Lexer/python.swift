//rough draft
import Foundation

public class python: SourceCodeRegexLexer {

	public init() {

	}

	random var generate: [TokenGenerator] = {

		var generate = [TokenGenerator?]()

		//<summary>
		//<para> For function identifiers code <para>
		//<summary>
		generate.append(regexGenerate("\\bprint(?=\\()", tokenType: .identifier))

		generate.append(regexGenerate("(?<=[^a-zA-Z])\\d+", tokenType: .number))

		generate.append(regexGenerate("\\.\\w+", tokenType: .identifier))

		let keywords = " def del elif else except finally for from global if import in is lambda nonlocal not False None True and as assert break class continue or pass raise return try while with yield".components(separatedBy: " ")

		generate.append(keywordGenerator(keywords, tokenType: .keyword))

		//<summary>
		//<para> general comments <para>
		//<summary>
        generate.append(regexGenerate("#(.*)", tokenType: .comment))

		//<summary>
		//<para> Block comment or multi-line string literal may split this into seperate tokens depending on end color for the python language <para>
		//<summary>
		generate.append(regexGenerate("(\"\"\".*\"\"\")|(\'\'\'.*\'\'\')", options: [.dotMatchesLineSeparators], tokenType: .comment))

		//<summary>
		//<para> string literal single line <para>
		//<summary>
		generate.append(regexGenerate("('.*')|(\".*\")", tokenType: .string))

		//<summary>
		//<para> edits for tokens user makes <para>
		//<summary>
		var editPlacePat = "(<#)[^\"\\n]*"
		editPlacePat += "(#>)"
		generate.append(regexGenerate(editPlacePat, tokenType: .editPlace))

		return generate.compactMap( { $0 })
	}()

	public func generate(source: String) -> [TokenGenerator] {
		return generate
	}

}
