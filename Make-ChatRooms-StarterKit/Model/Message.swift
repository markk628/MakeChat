//
//  Message.swift
//  Make-ChatRooms-StarterKit
//
//  Created by Mark Kim on 4/8/21.
//  Copyright © 2021 Matthew Harrilal. All rights reserved.
//

import Foundation

class Message: Codable {
    let messageContent: String
    let senderUsername: String
    var messageSender: Bool?
    var roomOriginName: String
    
    private enum CodingKeys: String, CodingKey {
        case messageContent
        case senderUsername
        case messageSender
        case roomOriginName
    }
    
    init(messageContent: String, senderUsername: String, messageSender: Bool?, roomOriginName: String) {
        self.messageContent = messageContent
        self.senderUsername = senderUsername
        self.messageSender = messageSender
        self.roomOriginName = roomOriginName
    }
    
    required convenience init(from decoder: Decoder) {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        let messageContent = try? container?.decode(String.self, forKey: .messageContent) ?? ""
        let senderUsername = try? container?.decode(String.self, forKey: .senderUsername) ?? ""
        let messageSender = try? container?.decodeIfPresent(Bool.self, forKey: .messageSender) ?? false
        let roomOriginName = try? container?.decode(String.self, forKey: .roomOriginName) ?? ""
        
        self.init(messageContent: messageContent ?? "", senderUsername: senderUsername ?? "", messageSender: messageSender, roomOriginName: roomOriginName ?? "")
    }
}
