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
        return storage["TurnstileSubject"] as! Subject
    }
}
