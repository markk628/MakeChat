//
//  protocols.swift
//  Make-ChatRooms-StarterKit
//
//  Created by Matthew Harrilal on 2/18/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation

protocol RoomTransition: class {
    func transitionToRoom()
}

protocol UsernameDelegate: class {
    func usernameCollision()
}

protocol MessageInputDelegate: class {
    func sendWasTapped(message: String)
}

protocol ReceivedMessage: class {
    func receivedMessage(message: Message)
}
