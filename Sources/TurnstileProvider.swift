//
//  VaporTurnstile.swift
//  VaporTurnstile
//
//  Created by Edward Jiang on 7/26/16.
//
//

import Vapor
import Turnstile

public class TurnstileProvider: Provider {
    public let turnstile: Turnstile
    public let provided = Providable()
    
    public init(realm: Realm) {
        turnstile = Turnstile(sessionManager: MemorySessionManager(), realm: realm)
    }
    
    required public init(config: Config) throws {
        preconditionFailure()
    }
    
    public func afterInit(_ droplet: Droplet) {
        // Backwards for some reason?
        droplet.middleware.append(BearerAuthMiddleware(turnstile: turnstile))
        droplet.middleware.append(BasicAuthMiddleware(turnstile: turnstile))
        droplet.middleware.append(SessionMiddleware(turnstile: turnstile))
        droplet.middleware.append(UserInitializationMiddleware(turnstile: turnstile))
    }
    
    public func beforeServe(_: Droplet) {
    }
}
