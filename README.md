# PaversParsec

A framework rewritten Haskell Parsec library in Swift. 

Its re-implementation follows the idea of Daan Leijen and Erik Meijer in their paper [Parsec: Direct Style Monadic Parser Combinators For The Real World](https://www.microsoft.com/en-us/research/wp-content/uploads/2016/02/parsec-paper-letter.pdf)

Moreover this framework interprets the Haskell code of [Parsec](https://github.com/haskell/parsec) in to Swift with some changes to adapt features of Swift, like laziness, generic.

## Dependencies
This framework depends on [PaversFRP](https://github.com/KeithPiTsui/PaversFRP) 
and [PaversSugar](https://github.com/KeithPiTsui/PaversSugar).

## Uses

There are two applications of this framework.

One is for interpretion of JSON. [PaversJSON](https://github.com/KeithPiTsui/PaversJSON)

Another is for compiler of [Kaleidoscope](https://llvm.org/docs/tutorial/LangImpl01.html). [SwiftParsecKaleidoscope](https://github.com/KeithPiTsui/SwiftParsecKaleidoscope)

