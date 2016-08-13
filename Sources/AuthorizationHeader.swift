//
//  AuthorizationHeader.swift
//  VaporTurnstile
//
//  Created by Edward Jiang on 7/28/16.
//
//

import CryptoEssentials
import Foundation
import Turnstile
import HTTP

struct AuthorizationHeader {
    let headerValue: String
    
    init?(value: String?) {
        guard let value = value else { return nil }
        headerValue = value
    }
    
    var basic: APIKey? {
        guard let range = headerValue.range(of: "Basic ") else { return nil }
        let token = headerValue.substring(from: range.upperBound)
        
        guard let decodedToken = try? Base64.decode(token).string,
            let separatorRange = decodedToken.range(of: ":") else {
            return nil
        }
        
        let apiKeyID = decodedToken.substring(to: separatorRange.lowerBound)
        let apiKeySecret = decodedToken.substring(from: separatorRange.upperBound)
        
        return APIKey(id: apiKeyID, secret: apiKeySecret)
    }
    
    var bearer: AccessToken? {
        guard let range = headerValue.range(of: "Bearer ") else { return nil }
        let token = headerValue.substring(from: range.upperBound)
        return AccessToken(string: token)
    }
}

extension Request {
    var auth: AuthorizationHeader? {
        return AuthorizationHeader(value: self.headers["Authorization"])
    }
}
