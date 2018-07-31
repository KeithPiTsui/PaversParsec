# PaversParsec

A framework rewritten Haskell [Parsec](https://github.com/haskell/parsec) library in Swift. 

Its re-implementation follows the idea of Daan Leijen and Erik Meijer in their paper [Parsec: Direct Style Monadic Parser Combinators For The Real World](https://www.microsoft.com/en-us/research/wp-content/uploads/2016/02/parsec-paper-letter.pdf)

Moreover this framework interprets the Haskell code of [Parsec](https://github.com/haskell/parsec) in to Swift with some changes to adapt features of Swift, like laziness, generic.

## Dependencies
This framework depends on [PaversFRP](https://github.com/KeithPiTsui/PaversFRP) 
and [PaversSugar](https://github.com/KeithPiTsui/PaversSugar).

## Example

That is an example from [Parsec](https://github.com/haskell/parsec).

0. The following example use Xcode 10 as build environment. Given you have installed [xcode 10](https://developer.apple.com/download/)
```bash
sudo xcode-select --switch /Applications/Xcode10-beta.app/Contents/Developer
```

1. Install PaversParsec with Swift package manager.

```bash
mkdir ParenParser
cd ParenParser
swift package init --type executable
vi Package.swift
```

2. Edit Package.swift to add dependencies for our ParenParser.
```swift
// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ParenParser",
    dependencies: [
        // Dependencies declare other packages that this package depends on.
      .package(url: "https://github.com/KeithPiTsui/PaversFRP.git", from: "1.0.0"),
      .package(url: "https://github.com/KeithPiTsui/PaversParsec.git", from: "1.0.1"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "ParenParser",
            dependencies: ["PaversFRP", "PaversParsec"]),
    ]
)
```

3. We construct a parser for parsing parentheses matching by edit Sources/ParenParser/main.swift as following.

```bash
vi Sources/ParenParser/main.swift
```

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

print("------------------")

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

4. Build and execute.

```bash
swift build
./.build/x86_64-apple-macosx10.10/debug/ParenParser
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
