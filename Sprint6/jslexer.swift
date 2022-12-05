//Currently we tried running the lexer files on python and are running into multiple errors that we do not understand.
//However, we are going to go try to talk to our 665 professor about these errors and see if he can lead us in the correct direction.
//If this does not work and even if it does I believe we will try to look into other ways to produce a highlighter in the next sprint.
//We are planning on writing a short report as to why this will not work/ why we can’t get it to work and find a different solution
//idea behind coloring syntax
import Foundation

public class javaScript: SourceCodeRegexLexer {

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

        let builtObjIden = "Infinity NaN undefined null globalThis Object Function Boolean Symbol Error AggregateError  EvalError InternalError  RangeError ReferenceError SyntaxError TypeError URIError Number BigInt Math Date String RegExp Array Int8Array Uint8Array Uint8ClampedArray Int16Array Uint16Array Int32Array Uint32Array Float32Array Float64Array BigInt64Array BigUint64Array Map Set WeakMap WeakSet ArrayBuffer SharedArrayBuffer  Atomics  DataView JSON Promise Generate GenerateFunction AsyncFunc Iterator  AsyncIter  Reflect Proxy Intl Intl.Collator Intl.DateTimeFormat Intl.ListFormat Intl.NumberFormat Intl.PluralRules Intl.RelativeTimeFormat Intl.Locale arguments".components(separatedBy: " ")

        let lamdaFunc = "__ add addIndex adjust all allPass always and andThen any anyPass ap aperture append apply applySpec applyTo ascend assoc assocPath binary bind both call chain clamp clone comparator complement compose composeK composeP composeWith concat cond construct constructN contains converge countBy curry curryN dec defaultTo descend difference differenceWith dissoc dissocPath divide drop dropLast dropLastWhile dropRepeats dropRepeatsWith dropWhile either empty endsWith eqBy eqProps equals evolve F filter find findIndex findLast findLastIndex flatten flip forEach forEachObjIndexed fromPairs groupBy groupWith gt gte has hasIn hasPath head identical identity ifElse inc includes indexBy indexOf init innerJoin insert insertAll intersection intersperse into invert invertObj invoker is isEmpty isNil join juxt keys keysIn last lastIndexOf length lens lensIndex lensPath lensProp lift liftN lt lte map mapAccum mapAccumRight mapObjIndexed match mathMod max maxBy mean median memoizeWith merge mergeAll mergeDeepLeft mergeDeepRight mergeDeepWith mergeDeepWithKey mergeLeft mergeRight mergeWith mergeWithKey min minBy modulo move multiply nAry negate none not nth nthArg o objOf of omit once or otherwise over pair partial partialRight partition path pathEq pathOr paths pathSatisfies pick pickAll pickBy pipe pipeK pipeP pipeWith pluck prepend product project prop propEq propIs propOr props propSatisfies range reduce reduceBy reduced reduceRight reduceWhile reject remove repeat replace reverse scan sequence set slice sort sortBy sortWith split splitAt splitEvery splitWhen startsWith subtract sum symmetricDifference symmetricDifferenceWith T tail take takeLast takeLastWhile takeWhile tap test thunkify times toLower toPairs toPairsIn toString toUpper transduce transpose traverse trim tryCatch type unapply unary uncurryN unfold union unionWith uniq uniqBy uniqWith unless unnest until update useWith values valuesIn view when where whereEq without xor xprod zip zipObj zipWith".components(separatedBy: " ")

        generate.append(keywordGenerate(lamdaFunc, tokenType: .identifier))

        generate.append(keywordGenerate(builtObjIden, tokenType: .identifier))

        generate.append(keywordGenerate(keywords, tokenType: .keyword))

        //<summary>
        //<para> regular comment tokenizer <para>
        //<summary>
        generate.append(regexGenerate("//(.*)", tokenType: .comment))

        //<summary>
        //<para> summary comments but depending on our color code may be same as the above tokenType
        //something currently wrong with the generation of tokens for summary comments <para>
        //<summary>
        generate.append(regexGenerate("(/\\*)(.*)(\\*/)", options: [.dotMatchesLineSeparators], tokenType: .comment))

        //<summary>
        //<para> string literal for single line
        //something currently wrong with the generation of tokens for single line<para>
        //<summary>
        generate.append(regexGenerate("(\"|@\")[^\"\\n]*(@\"|\")", tokenType: .string))

        //<summary>
        //<para> string literal for multi line but depending on our color code may be same as the above tokenType
        //something currently wrong with the generation of tokens for multi line<para>
        //<summary>
        generate.append(regexGenerate("(\"\"\")(.*?)(\"\"\")", options: [.dotMatchesLineSeparators], tokenType: .string))

        //<summary>
        //<para> edits made for tokens <para>
        //<summary>
        var editorPlaceholderPattern = "(<#)[^\"\\n]*"
        editorPlaceholderPattern += "(#>)"
        generate.append(regexGenerate(editorPlaceholderPattern, tokenType: .editorPlaceholder))

        return generate.compactMap( { $0 })
    }()

    public func generate(source: String) -> [TokenGenerate] {
        return generate
    }

}
