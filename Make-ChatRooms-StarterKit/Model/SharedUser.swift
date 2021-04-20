//
//  SharedUser.swift
//  Make-ChatRooms-StarterKit
//
//  Created by Mark Kim on 3/28/21.
//  Copyright © 2021 Matthew Harrilal. All rights reserved.
//

import Foundation

class SharedUser {
    static var shared = SharedUser()
    var user: User?
    
    private init() {
        print("user created \(user)")
    }
}
