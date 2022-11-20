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
