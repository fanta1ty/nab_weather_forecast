//
//  PromotionParemeter.swift
//  ExampleConcept
//
//  Created by Dat Huynh on 10/07/2021.
//

struct GeneralParameter {
    let size: Int?
    let page: Int?
    let sort: String?
    
    init(size: Int?,
         page: Int?,
         sort: String?) {
        
        self.size = size
        self.page = page
        self.sort = sort
    }
}

extension GeneralParameter: RequestParameter {
    var requestParameter: [String: Any] {
        var parameter = [String: Any]()
        parameter[RequestField.General.size] = size
        parameter[RequestField.General.page] = page
        parameter[RequestField.General.sort] = sort
        
        return parameter
    }
}
