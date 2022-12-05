{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE TupleSections #-}
{-# OPTIONS_GHC -fno-warn-missing-fields #-}

module GHC.SyntaxHighlighter
  ( MyToken (..),
    MyLocation (..),
    tokeneHaskell,
    tokenHaskellMyLocation,
  )
where

import Control.Monad
import Data.List 
import Data.Maybe 
import Data.Text (Text)
import qualified Data.Text as T
import qualified GHC.Data.EnumSet as ES

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
    RationalNumberToken
  | 
    CommentToken
  | 
    SpaceToken
  | 
    OtherToken
  deriving (Eq, Ord, Enum, Bounded, Show)
  
  data MyLocation = Location !Int !Int !Int !Int
  deriving (Eq, Ord, Show)
  
  tokenHaskell :: Text -> Maybe [(Token, Text)]
  tokenHaskell input = breakInput input <$> tokenHaskellMyLocation input
  
  --locations replaced with input text
  breakInput :: Text -> [(Token, MyLocation)] -> [(Token, Text)]
  breakInput input the_tokens = unfoldr breakOnce (startText' input, the_tokens)
  where
    breakOnce (txt, []) = do
      (txt', block) <- getAll txt
      return ((SpaceToken, block), (txt', []))
    breakOnce (txt, test@((to, l) : ts)) =
      case getAll txt l of
        Nothing ->
          let (txt', block) = getSpan txt l
              to' = case to of
                the_token -> the_token
           in Just ((to', block), (txt', ts))
        Just (txt', block) ->
          Just ((SpaceTok, block), (txt', test))
          
 --provides locations 
 tokenHaskellMyLocation :: Text -> Maybe [(Token, MyLocation)]
 tokenHaskellLoc input =
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
        
   --creation of lexer
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
            
  --fix design 
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
  L.ITunknown _ -> OtherToken
  L.ITeof -> OtherToken
 
  L.ITdocComment {} -> CommentToken
  L.ITdocOptions {} -> CommentToken
  L.ITlineComment {} -> CommentToken
  L.ITblockComment {} -> CommentToken
