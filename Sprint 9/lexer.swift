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

    func advance() {
        guard currentIndex < input.endIndex else {
            currentChar = nil
            return
        }
        currentChar = input[currentIndex]
        currentIndex = input.index(after: currentIndex)
    }

    func getNextToken() -> Token? {
        skipWhiteSpaceAndComments()

        guard let char = currentChar else { return nil }

        if char.isLetter {
            let word = getWord()
            if let color = keywordColors[word] {
                return Token(type: .keyword, range: currentIndex..<input.index(currentIndex, offsetBy: -word.count), color: color)
            } else {
                return Token(type: .identifier, range: currentIndex..<input.index(currentIndex, offsetBy: -word.count), color: .black)
            }
        } else if char.isNumber {
            return Token(type: .number, range: currentIndex..<input.index(before: currentIndex), color: .magenta)
        } else if char == "\"" {
            let string = getString()
            return Token(type: .string, range: currentIndex..<input.index(currentIndex, offsetBy: -string.count-2), color: .red)
        } else {
            advance()
        }

        return nil
    }

    func getWord() -> String {
        var word = ""
        while let char = currentChar, char.isLetter || char.isNumber || char == "_" {
            word.append(char)
            advance()
        }
        return word
    }

    func getString() -> String {

