//
//  Request+Turnstile.swift
//  VaporTurnstile
//
//  Created by Edward Jiang on 7/26/16.
//
//

import Turnstile
import HTTP

public extension Request {
    internal(set) public var user: Subject {
        get {
            return storage["TurnstileSubject"] as! Subject
        }
        set {
            storage["TurnstileSubject"] = newValue
        }
    }
}
