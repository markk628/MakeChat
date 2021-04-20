//
//  User.swift
//  Make-ChatRooms-StarterKit
//
//  Created by Mark Kim on 3/28/21.
//  Copyright © 2021 Matthew Harrilal. All rights reserved.
//

import Foundation

class User {
    var username: String
    var activeRooms: [Room]?
    
    init(username: String, activeRooms: [Room]?) {
        self.username = username
        self.activeRooms = activeRooms
    }
}
