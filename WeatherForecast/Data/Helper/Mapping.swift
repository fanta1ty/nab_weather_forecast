import Foundation

protocol Mapping {
    associatedtype SourceType
    associatedtype DestinationType
    
    func map(source: SourceType) -> DestinationType
}
