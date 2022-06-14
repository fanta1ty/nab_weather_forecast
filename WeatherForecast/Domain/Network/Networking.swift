import Foundation
import RxSwift

protocol Networking {
    
    func get<T, P: Parser>(path: String,
                           parameters: RequestParameter?,
                           encoder: ParameterEncoder?,
                           headers: Header,
                           parser: P) -> Observable<T> where P.R == T
    
    func post<T, P: Parser>(path: String,
                            parameters: RequestParameter?,
                            encoder: ParameterEncoder?,
                            headers: Header,
                            parser: P) -> Observable<T> where P.R == T
    
    func post<T, P: Parser>(path: String,
                            parameterStringArray: [String],
                            encoder: ParameterEncoder?,
                            headers: Header,
                            parser: P) -> Observable<T> where P.R == T
    
    func put<T, P: Parser>(path: String,
                           parameters: RequestParameter?,
                           encoder: ParameterEncoder?,
                           headers: Header,
                           parser: P) -> Observable<T> where P.R == T
    
    func delete<T, P: Parser>(path: String,
                              parameters: RequestParameter?,
                              encoder: ParameterEncoder?,
                              headers: Header,
                              parser: P) -> Observable<T> where P.R == T
    
    func deleteNoContentRequest<T, P: Parser>(path: String,
                                              encoder: ParameterEncoder?,
                                              headers: Header,
                                              parser: P) -> Observable<T> where P.R == T
    
    func patch<T, P: Parser>(path: String,
                             parameters: RequestParameter?,
                             encoder: ParameterEncoder?,
                             headers: Header,
                             parser: P) -> Observable<T> where P.R == T
}
