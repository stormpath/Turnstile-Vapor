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
    
    public init(realms: [Realm]) {
        turnstile = Turnstile(sessionManager: MemorySessionManager(), realms: realms)
    }
    
    public func boot(with droplet: Droplet) {
        droplet.add(SubjectInitializationMiddleware(turnstile: turnstile))
        droplet.add(SessionMiddleware(turnstile: turnstile))
        droplet.add(BasicAuthMiddleware(turnstile: turnstile))
    }
}
