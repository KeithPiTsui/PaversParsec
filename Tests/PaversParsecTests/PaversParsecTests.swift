import XCTest
@testable import PaversParsec
import PaversFRP

final class PaversParsecTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
      let notAt: ParserS<Character> = not("@")
      let at: ParserS<Character> = char("@")
      let prefix: ParserS<String> = string("QWC:")
      let pattern: ParserS<String?> = ((at >>- prefix >>- notAt.*) -<< at)
        .fmap{String.init($0)}
      
      let anyString: ParserS<String?> = anyChar().fmap{_ in nil}
      
      let matchingString: ParserS<String?> = ((try_(pattern) <|> anyString).*)
        .fmap{$0.compact().first}
      
      let state: ParserState<String, ()> = "http://521qw.com@QWC:ios_ns_20918_212@cse@ce@"
      let result = matchingString.unParser(state)
      print(result)
      
    }


    static var allTests = [
        ("testExample", testExample),
    ]
}
