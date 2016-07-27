//
//  VaporTurnstile.swift
//  VaporTurnstile
//
//  Created by Edward Jiang on 7/26/16.
//
//

import Vapor
import Turnstile

public class VaporTurnstile: Provider {
    public let turnstile: Turnstile
    
    public init() {
        turnstile = Turnstile(sessionManager: VaporSessionManager())
    }
    
    public func boot(with droplet: Droplet) {
        Turnstile.sharedTurnstile = turnstile // HACK - fix sometime
    }
}
