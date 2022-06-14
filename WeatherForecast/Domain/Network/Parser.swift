import Foundation

protocol Parser {
    associatedtype R
    func parse(from response: Response) throws -> R
}
