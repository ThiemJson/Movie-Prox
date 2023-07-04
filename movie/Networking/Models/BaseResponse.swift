//
//  OHResponse.swift
//  movie
//
//  Created by Prox on 24/03/2023.
//  Copyright © 2023 Prox. All rights reserved.
//

import Foundation

public class BaseResponse: BaseModel, DefaultErrorModel {
    public var code     : Int?
    public var anyData  : Any?
    public var message  : String?
    public var success  : Bool?
    
    enum CodingKeys: String, CodingKey {
        case code       = "status_code"
        case message    = "status_message"
        case data       = "data"
        case success    = "success"
    }
    
    public required init() {
        super.init()
    }
    
    public required init(from decoder: Decoder) throws {
        super.init()
        let container   = try decoder.container(keyedBy: CodingKeys.self)
        code            = try? container.decode(Int.self, forKey: .code)
        message         = try? container.decode(String.self, forKey: .message)
        success         = try? container.decode(Bool.self, forKey: .success)
    }
    
    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(code, forKey: .code)
        try? container.encode(message, forKey: .message)
        try? container.encode(success, forKey: .success)
    }
}
