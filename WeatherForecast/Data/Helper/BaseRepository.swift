import Foundation

class BaseRepository<Mapper> {
    let mapper: Mapper
    
    init(mapper: Mapper) {
        self.mapper = mapper
    }
}

class BaseRepositoryImpl {
    let networking: Networking
    
    init(networking: Networking) {
        self.networking = networking
    }
}
