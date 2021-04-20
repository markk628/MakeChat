//
//  ChatRoom.swift
//  Make-ChatRooms-StarterKit
//
//  Created by Matthew Harrilal on 2/18/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import Foundation
import SocketIO

class ChatRoom {
    
    static var shared = ChatRoom()
    static var port = 4000 // This is your choice
    static let manager = SocketManager(socketURL: URL(string: "http://localhost:\(port)/")!, config: [.log(true), .compress])

    private var socket = manager.defaultSocket
    
    weak var usernameCollisionDelegate: UsernameDelegate?
    weak var roomTransitionDelegate: RoomTransition?
    var receivedMessageDelegate: ReceivedMessage?
    
    init() {
        socket.connect()
        eventListeners()
    }
    
    func eventListeners() {
        // Mark: TODO Create event listener for when user connects
        socket.on(clientEvent: .connect) { (data, ack) in
            print("User has connected")
        }
        
        socket.on("usernameCollision") { (data, ack) in
//            print("There has been a username collision, please try a new username")
            self.usernameCollisionDelegate?.usernameCollision()
        }
        
        socket.on("validUsername") { (data, ack) in
            print("Username has chosen a valid username")

            let username = data[0]
//            let userDefaults = UserDefaults()
            Constants.userDefaults.set(String(describing: username), forKey: "socketUsername")
            
            self.roomTransitionDelegate?.transitionToRoom()
            SharedUser.shared.user = User(username: username as! String, activeRooms: [])
        }
        
        socket.on("chat message") { (data, ack) in
            guard let message = try? JSONDecoder().decode(Message.self, from: data[0] as! Data) else { return }
            self.receivedMessageDelegate?.receivedMessage(message: message)
        }
    }
    
    // Mark: Todo and event emitters to send the nickname over the server
    
    func sendUsername(user: User) {
        socket.emit("socketUsername", user.username)
    }
    
    func joinChatroom(room: Room) {
        socket.emit("joinRoom", room.roomName)
    }
    
    func sendMessage(message: Message) {
        guard let jsonData = try? JSONEncoder().encode(message) else { return }
        
        self.socket.emit("chat message", jsonData)
    }
}
