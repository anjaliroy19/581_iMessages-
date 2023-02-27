import UIKit

enum TokenType {
    case keyword
    case identifier
    case number
    case string
    case comment
}

struct Token {
    let type: TokenType
    let range: Range<String.Index>
    let color: UIColor
}

class Lexer {
    let input: String
    var currentIndex: String.Index
    var currentChar: Character?
    var tokens: [Token] = []

    let keywordColors: [String: UIColor] = [
        let m_white = Color(red: 246/255, green: 246/255, blue: 246/255)
        let m_black = Color(red: 30/255, green: 30/255, blue: 31/255)
        let m_lightgray = Color(red: 202/255, green: 204/255, blue: 210/255)
        let m_rose = Color(red: 234/255, green: 66/255, blue: 143/255)
        let m_red = Color(red: 233/255, green: 64/255, blue: 47/255)
        let m_yellow = Color(red: 223/255, green: 253/255, blue: 82/255)
        let m_lizardgreen = Color(red: 174/255, green: 250/255, blue: 78/255)
        let m_springgreen = Color(red: 116/255, green: 251/255, blue: 175/255)
        let m_blue = Color(red: 102/255, green: 221/255, blue: 239/255)
        "int": .orange,
        "float": .orange,
        "double": .orange,
        "char": .orange,
        "bool": .orange,
        "void": .orange,
        "class": .purple,
        "struct": .purple,
        "enum": .purple,
        "typedef": .purple,
        "template": .purple,
        "namespace": .purple,
        "using": .purple,
        "return": .blue,
        "if": .blue,
        "else": .blue,
        "switch": .blue,
        "case": .blue,
        "default": .blue,
        "while": .blue,
        "do": .blue,
        "for": .blue,
        "break": .blue,
        "continue": .blue,
        "goto": .blue,
        "new": .red,
        "delete": .red,
        "operator": .red,
        "sizeof": .red,
        "true": .green,
        "false": .green,
        "nullptr": .green,
        "static_cast": .red,
        "const_cast": .red,
        "dynamic_cast": .red,
        "reinterpret_cast": .red,
        "public": .lightGray,
        "private": .lightGray,
        "protected": .lightGray,
        "virtual": .lightGray,
        "override": .lightGray,
        "final": .lightGray,
        "friend": .lightGray,
    ]

    init(input: String) {
        self.input = input
        currentIndex = input.startIndex
    }

    /// Advances the current index and sets the current character to the next character in the input string.
    func advance() {
        guard currentIndex < input.endIndex else {
            currentChar = nil
            return
        }
        currentChar = input[currentIndex]
        currentIndex = input.index(after: currentIndex)
    }

    /// Skips over any white space and comments in the input string.
    func skipWhiteSpaceAndComments() {
        while let char = currentChar {
            if char.isWhitespace {
                advance()
            } else if char == "/" && input[currentIndex..<input.index(after: currentIndex)] == "//" {
                skipSingleLineComment()
            } else if char == "/" && input[currentIndex..<input.index(after: currentIndex)] == "/*" {
                skipMultiLineComment()
            } else {
                break
            }
        }
    }

    /// Skips over a single line comment in the input string.
    func skipSingleLineComment() {
        advance()
        advance()

        while let char = currentChar, char != "\n" {
            advance()
        }
    }

    /// Skips over a multi-line comment in the input string.
    func skipMultiLineComment() {
        advance()
        advance()

        while let char = currentChar {
            if char == "*" && input[currentIndex..<input.index(after: currentIndex)] == "/" {
                advance()
                advance()
                break
            } else {
                advance()
            }
        }
