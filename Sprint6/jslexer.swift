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


// different method

--Types
data Token
  = 
    KeywordToken
  | 
    SymbolToken
  | 
    VariableToken
  | 
    ConstructorToken
  | 
    OperatorToken
  |
    CharToken
  | 
    StringToken
  |
    IntegerToken
  | 
    CommentToken

  deriving (Eq, Ord, Enum, Bounded, Show)
  
  data MyLocation = Location !Int !Int !Int !Int
  deriving (Eq, Ord, Show)
  
  tokenJavaS :: Text -> Maybe [(Token, Text)]
  tokenJavaS input = breakInput input <$> tokenJavaSMyLocation input
  
  
  //<summary>
//<para>  locations replaced with input text <para>
//<summary>
  breakInput :: Text -> [(Token, MyLocation)] -> [(Token, Text)]
  breakInput input the_tokens = unfoldr breakOnce (startText' input, the_tokens)
  where
    breakOnce (txt, []) = do
      (txt', block) <- getAll txt
    breakOnce (txt, test@((to, l) : ts)) =
      case getAll txt l of
        Nothing ->
          let (txt', block) = getSpan txt l
              to' = case to of
                the_token -> the_token
           in Just ((to', block), (txt', ts))
        Just (txt', block) ->
          Just ((SpaceTok, block), (txt', test))
          
          //<summary>
        //<para> location given <para>
        //<summary>
 tokenJavaSMyLocation :: Text -> Maybe [(Token, MyLocation)]
 tokenJavaSLoc input =
  case L.unP parseLexer parseState of
    L.PFailed {} -> Nothing
    L.POk _ x -> Just x
  where
    loc = srcLoc (getString "") 1 1
    buffer = stringBuffer (T.unpack input)
    parseState = L.startParser parserOpts buffer loc
    parserOpts =
      L.getParserOpts
        (ES.fromList enabledExts)
        diagOptions
        []
        True -- imports
        True -- Haddock token
        True -- for comment tokens
        False -- lexer line
    diagOptions =
      DiagOptions
        { diag_warning_flags = ES.empty,
          diag_fatal_warning_flags = ES.empty,
          diag_warn_is_error = False,
          diag_reverse_errors = False,
          diag_max_errors = Nothing,
          diag_ppr_ctx = defaultSDocContext
        }
        
        //<summary>
      //<para>  lexer created here<para>
      //<summary>
   parseLexer :: L.P [(Token, MyLocation)]
   pareseLexer = go
  where
    go = do
      rate <- L.lexer False return
      case rate of
        L _ L.ITeof -> return []
        _ ->
          case fixDesignToken rate of
            Nothing -> go
            Just x -> (x :) <$> go
  fixDesignToken :: Located L.Token -> Maybe (Token, MyLocation)
  fixDesignToken (L srcSpan the_token) = (classifyToken the_token,) <$> srcLocation srcSpan
  
 -- | Convert 'SrcSpan' into 'Loc'.
srcSpanToLoc :: SrcSpan -> Maybe Loc
srcSpanToLoc (RealSrcSpan s _) =
  let srcSpanSLine = srcSpanStartLine s
      srcSpanSCol = srcSpanStartCol s
      srcSpanELine = srcSpanEndLine s
      srcSpanECol = srcSpanEndCol s
      start = (srcSpanSLine, srcSpanSCol)
      end = (srcSpanELine, srcSpanECol)
   in if start == end
        then Nothing -- NOTE Some magic auto-generated tokens that do not
        -- actually appear in the input stream. Drop them.
        else
          Just $
            Loc
              srcSpanSLine
              srcSpanSCol
              srcSpanELine
              srcSpanECol
srcSpanToLoc _ = Nothing

classifyToken :: L.Token -> Token
classifyToken = \case
  -- Keywords
  L.ITas -> KeywordToken
  L.ITcase -> KeywordToken
  L.ITlcases -> KeywordToken
  L.ITclass -> KeywordToken
  L.ITdata -> KeywordToken
  L.ITdefault -> KeywordToken
  L.ITderiving -> KeywordToken
  L.ITdo _ -> KeywordToken
  L.ITelse -> KeywordToken
  L.IThiding -> KeywordToken
  L.ITforeign -> KeywordToken
  L.ITif -> KeywordToken
  L.ITimport -> KeywordToken
  L.ITin -> KeywordToken
  L.ITinfix -> KeywordToken
  L.ITinfixl -> KeywordToken
  L.ITinfixr -> KeywordToken
  L.ITinstance -> KeywordToken
  L.ITlet -> KeywordToken
  L.ITmodule -> KeywordToken
  L.ITnewtype -> KeywordToken
  L.ITof -> KeywordToken
  L.ITqualified -> KeywordToken
  L.ITthen -> KeywordToken
  L.ITtype -> KeywordToken
  L.ITwhere -> KeywordToken
  L.ITforall _ -> KeywordToken
  L.ITexport -> KeywordToken
  L.ITlabel -> KeywordToken
  L.ITdynamic -> KeywordToken
  L.ITsafe -> KeywordToken
  L.ITinterruptible -> KeywordToken
  L.ITunsafe -> KeywordToken
  L.ITstdcallconv -> KeywordToken
  L.ITccallconv -> KeywordToken
  L.ITcapiconv -> KeywordToken
  L.ITprimcallconv -> KeywordToken
  L.ITjavascriptcallconv -> KeywordToken
  L.ITmdo _ -> KeywordToken
  L.ITfamily -> KeywordToken
  L.ITrole -> KeywordToken
  L.ITgroup -> KeywordToken
  L.ITby -> KeywordToken
  L.ITusing -> KeywordToken
  L.ITpattern -> KeywordToken
  L.ITstatic -> KeywordToken
  L.ITstock -> KeywordToken
  L.ITanyclass -> KeywordToken
  L.ITvia -> KeywordToken
  L.ITunit -> KeywordToken
  L.ITsignature -> KeywordToken
  L.ITdependency -> KeywordToken
  L.ITrequires -> KeywordToken
  -- Pragmas
  L.ITinline_prag {} -> PragmaToken
  L.ITspec_prag _ -> PragmaToken
  L.ITspec_inline_prag {} -> PragmaToken
  L.ITsource_prag _ -> PragmaToken
  L.ITrules_prag _ -> PragmaToken
  L.ITwarning_prag _ -> PragmaToken
  L.ITdeprecated_prag _ -> PragmaToken
  L.ITline_prag _ -> PragmaToken
  L.ITcolumn_prag _ -> PragmaToken
  L.ITscc_prag _ -> PragmaToken
  L.ITunpack_prag _ -> PragmaToken
  L.ITnounpack_prag _ -> PragmaToken
  L.ITann_prag _ -> PragmaToken
  L.ITcomplete_prag _ -> PragmaToken
  L.ITclose_prag -> PragmaToken
  L.IToptions_prag _ -> PragmaToken
  L.ITinclude_prag _ -> PragmaToken
  L.ITlanguage_prag -> PragmaToken
  L.ITminimal_prag _ -> PragmaToken
  L.IToverlappable_prag _ -> PragmaToken
  L.IToverlapping_prag _ -> PragmaToken
  L.IToverlaps_prag _ -> PragmaToken
  L.ITincoherent_prag _ -> PragmaToken
  L.ITctype _ -> PragmaToken
  L.ITcomment_line_prag -> PragmaToken
  L.ITopaque_prag _ -> PragmaToken
  -- kept symbols
  L.ITdotdot -> SymbolToken
  L.ITcolon -> SymbolToken
  L.ITdcolon _ -> SymbolToken
  L.ITequal -> SymbolToken
  L.ITlam -> SymbolToken
  L.ITlcase -> SymbolToken
  L.ITvbar -> SymbolToken
  L.ITlarrow _ -> SymbolToken
  L.ITrarrow _ -> SymbolToken
  L.ITlolly -> SymbolToken
  L.ITat -> SymbolToken
  L.ITtilde -> SymbolToken
  L.ITdarrow _ -> SymbolToken
  L.ITbang -> SymbolToken
  L.ITstar _ -> SymbolToken
  L.ITbiglam -> SymbolToken
  L.ITocurly -> SymbolToken
  L.ITccurly -> SymbolToken
  L.ITvocurly -> SymbolToken
  L.ITvccurly -> SymbolToken
  L.ITobrack -> SymbolToken
  L.ITopabrack -> SymbolToken
  L.ITcpabrack -> SymbolToken
  L.ITcbrack -> SymbolToken
  L.IToparen -> SymbolToken
  L.ITcparen -> SymbolToken
  L.IToubxparen -> SymbolToken
  L.ITcubxparen -> SymbolToken
  L.ITsemi -> SymbolToken
  L.ITcomma -> SymbolToken
  L.ITunderscore -> SymbolToken
  L.ITbackquote -> SymbolToken
  L.ITsimpleQuote -> SymbolToken
  L.ITpercent -> SymbolToken
  L.ITproj _ -> SymbolToken
  -- operator
  L.ITminus -> OperatorToken
  L.ITprefixminus -> OperatorToken
  L.ITdot -> OperatorToken
  -- Id
  L.ITvarid _ -> VariableToken
  L.ITconid _ -> ConstructorToken
  L.ITvarsym _ -> OperatorToken
  L.ITconsym _ -> OperatorToken
  L.ITqvarid _ -> VariableToken
  L.ITqconid _ -> ConstructorToken
  L.ITqvarsym _ -> OperatorToken
  L.ITqconsym _ -> OperatorToken
  L.ITdupipvarid _ -> VariableToken
  L.ITlabelvarid _ -> VariableToken
  -- Basic
  L.ITchar _ _ -> CharToken
  L.ITstring _ _ -> StringToken
  L.ITinteger _ -> IntegerToken
  L.ITrational _ -> RationalToken
  L.ITprimchar _ _ -> CharToken
  L.ITprimstring _ _ -> StringToken
  L.ITprimint _ _ -> IntegerToken
  L.ITprimword _ _ -> IntegerToken
  L.ITprimfloat _ -> RationalToken
  L.ITprimdouble _ -> RationalToken
  -- Template 
  L.ITopenExpQuote _ _ -> SymbolToken
  L.ITopenPatQuote -> SymbolToken
  L.ITopenDecQuote -> SymbolToken
  L.ITopenTypQuote -> SymbolToken
  L.ITcloseQuote _ -> SymbolToken
  L.ITopenTExpQuote _ -> SymbolToken
  L.ITcloseTExpQuote -> SymbolToken
  L.ITtyQuote -> SymbolToken
  L.ITquasiQuote _ -> SymbolToken
  L.ITqQuasiQuote _ -> SymbolToken
  L.ITdollar -> SymbolToken
  L.ITdollardollar -> SymbolToken
  -- for arrow
  L.ITproc -> KeywordToken
  L.ITrec -> KeywordToken
  L.IToparenbar _ -> SymbolToken
  L.ITcparenbar _ -> SymbolToken
  L.ITlarrowtail _ -> SymbolToken
  L.ITrarrowtail _ -> SymbolToken
  L.ITLarrowtail _ -> SymbolToken
  L.ITRarrowtail _ -> SymbolToken
  
  L.ITtypeApp -> SymbolToken
  -- Special cases

 
  L.ITdocComment {} -> CommentToken
  L.ITdocOptions {} -> CommentToken
  L.ITlineComment {} -> CommentToken
  L.ITblockComment {} -> CommentToken
