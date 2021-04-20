//
//  ChatRoomViewController.swift
//  Make-ChatRooms-StarterKit
//
//  Created by Mark Kim on 4/10/21.
//  Copyright © 2021 Matthew Harrilal. All rights reserved.
//

import UIKit

class ChatRoomViewController: UIViewController {
    
    let tableView = UITableView()
    let messageInputBar = MessageInputView()
    var roomName = ""
    
    var messages = [Message]()

//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        ChatRoom.shared.receivedMessageDelegate = self
    }

}


