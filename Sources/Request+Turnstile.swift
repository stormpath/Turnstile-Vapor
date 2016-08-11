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
    public var user: User {
        return storage["TurnstileUser"] as! User
    }
}
