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
import Vapor

struct AuthorizationHeader {
    let headerValue: String
    
    init?(value: String?) {
        guard let value = value else { return nil }
        headerValue = value
    }
    
    var basic: APIKeyCredentials? {
        guard let range = headerValue.range(of: "Basic ") else { return nil }
        let token = headerValue.substring(from: range.upperBound)
        
        let decodedToken: String
        do {
            decodedToken = String(try Base64.decode(token))
        } catch {
            return nil
        }
        
        guard let separatorRange = decodedToken.range(of: ":") else {
            return nil
        }
        
        let apiKeyID = decodedToken.substring(to: separatorRange.lowerBound)
        let apiKeySecret = decodedToken.substring(from: separatorRange.upperBound)
        
        return APIKeyCredentials(id: apiKeyID, secret: apiKeySecret)
    }
    
    var bearer: TokenCredentials? {
        guard let range = headerValue.range(of: "Bearer ") else { return nil }
        let token = headerValue.substring(from: range.upperBound)
        return TokenCredentials(token: token)
    }
}

extension Request {
    var auth: AuthorizationHeader? {
        return AuthorizationHeader(value: self.headers["Authorization"])
    }
}
