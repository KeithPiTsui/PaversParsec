# PaversParsec

A framework rewritten Haskell [Parsec](https://github.com/haskell/parsec) library in Swift. 

Its re-implementation follows the idea of Daan Leijen and Erik Meijer in their paper [Parsec: Direct Style Monadic Parser Combinators For The Real World](https://www.microsoft.com/en-us/research/wp-content/uploads/2016/02/parsec-paper-letter.pdf)

Moreover this framework interprets the Haskell code of [Parsec](https://github.com/haskell/parsec) in to Swift with some changes to adapt features of Swift, like laziness, generic.

## Dependencies
This framework depends on [PaversFRP](https://github.com/KeithPiTsui/PaversFRP) 
and [PaversSugar](https://github.com/KeithPiTsui/PaversSugar).

## Example

Given PaversParsec installed with Swift package manager.
We construct a parser for parsing parentheses matching, that is an example from [Parsec](https://github.com/haskell/parsec).

```swift
import PaversParsec
import PaversFRP

func parenSet () -> ParserS<()> {
  let left: ParserS<()> = char("(").fmap(terminal) <?> "("
  let right: ParserS<()> = char(")").fmap(terminal) <?> ")"
  let mParen: LazyParserS<()> = fmap( many(parenSet), terminal)
  return left >>- mParen >>- right
}

let parens: LazyParserS<()> = (many(parenSet) >>- eof()) <|> eof()
let parser = parens()

let input1 = ParserStateS("()(())")
let result1 = parser.unParser(input1)
print(result1)
/**
ParserResult: Consumed
Parse OK
Got: ():()
*/

let input = ParserStateS("(")
let result = parser.unParser(input)
print(result)
/**
ParserResult: Consumed
Parse Failed
Message:
{file: init, line: 1, column: 2}: 
msgUnexpected msgEndOfInput
msgExpecting )
*/
```

The `Parse OK` results indicate successes: the parentheses matched.
The `Parse Failed` result indicates a parse failure, and is detailed
with an error message.

## Use Cases

There are two applications of this framework.

One is for interpretion of JSON. [PaversJSON](https://github.com/KeithPiTsui/PaversJSON)

Another is for compiler of [Kaleidoscope](https://llvm.org/docs/tutorial/LangImpl01.html). [SwiftParsecKaleidoscope](https://github.com/KeithPiTsui/SwiftParsecKaleidoscope)

## To-do

1. More use case for this library.

2. Make API documentation more descriptive and user-friendly.
