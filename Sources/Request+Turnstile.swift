//
//  Request+Turnstile.swift
//  VaporTurnstile
//
//  Created by Edward Jiang on 7/26/16.
//
//

import Turnstile
import Vapor

public extension Request {
    public var subject: Subject {
        guard let session = session else {
            preconditionFailure("Sessions must be enabled at the moment for this provider to work")
        }
        if session.identifier == nil {
            // Initialize the session and create a new Subject
            session["VaporAuth"] = "enabled"
        }
        
        return Turnstile.sharedTurnstile.sessionManager[session.identifier!]
    }
}
