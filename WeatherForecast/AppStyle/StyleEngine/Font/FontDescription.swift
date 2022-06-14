import UIKit

public struct FontDescription: Decodable {
    public let size: CGFloat
    public let name: String
    public let style: String
    
    public init(size: CGFloat, name: String, style: String) {
        self.size = size
        self.name = name
        self.style = style
    }
}
