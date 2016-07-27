//
//  VaporSessionManager.swift
//  VaporTurnstile
//
//  Created by Edward Jiang on 7/26/16.
//
//

import Turnstile

class VaporSessionManager: SessionManager {
    var sessions = [String: Subject]()
    weak var turnstile: Turnstile!
    
    func boot(turnstile: Turnstile) {
        self.turnstile = turnstile
    }
    
    subscript(identifier: String) -> Subject {
        get {
            if let subject = sessions[identifier] {
                return subject
            } else {
                let subject = Subject(turnstile: turnstile)
                sessions[identifier] = subject
                return subject
            }
        }
        set {
            sessions[identifier] = newValue
        }
    }
}
