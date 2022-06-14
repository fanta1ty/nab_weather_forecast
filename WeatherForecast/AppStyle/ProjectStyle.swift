import Foundation

public class ProjectStyle {
    public static var shared: ProjectStyle!
    
    let fontService: ProjectFontServicing
    
    init(fontService: ProjectFontServicing) {
        self.fontService = fontService
    }
    
    public func initialize() {
        fontService.initialize(completion: nil)
    }
}
