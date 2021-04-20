//
//  CreateUserViewController.swift
//  Make-ChatRooms-StarterKit
//
//  Created by Mark Kim on 3/28/21.
//  Copyright © 2021 Matthew Harrilal. All rights reserved.
//

import UIKit

class CreateUserViewController: UIViewController, UsernameDelegate, RoomTransition {
    
    let chatRoom = ChatRoom()

    override func viewDidLoad() {
        super.viewDidLoad()
        let createUserView = CreateUserView()
        createUserView.frame = self.view.bounds
        self.view.addSubview(createUserView)
        
        ChatRoom.shared.usernameCollisionDelegate = self
        ChatRoom.shared.roomTransitionDelegate = self
    }
    
    func usernameCollision() {
        let usernameAlert = UIAlertController(title: "Choose another name", message: "The username you chose is already taken", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Try Again", style: .cancel, handler: nil)
        
        usernameAlert.addAction(cancelAction)
        self.present(usernameAlert, animated: true, completion: nil)
    }
    
    func transitionToRoom() {
        print("User can successfully transition to the next view")
        let roomsTableView = RoomsTableViewController()
        
        self.navigationController?.pushViewController(roomsTableView, animated: true)
        
        print("Transitioning to Rooms Table View")
    }
}
