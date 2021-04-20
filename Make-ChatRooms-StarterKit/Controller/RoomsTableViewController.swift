//
//  RoomsTableViewController.swift
//  Make-ChatRooms-StarterKit
//
//  Created by Mark Kim on 4/8/21.
//  Copyright © 2021 Matthew Harrilal. All rights reserved.
//

import UIKit

class RoomsTableViewController: UITableViewController {
    
    var rooms: [Room] = [Room]()
    
    lazy var createRoomButton: UIBarButtonItem = {
        let createJoinRoomButton = UIBarButtonItem(title: "Create Room", style: .plain, target: self, action: #selector(createRoom(sender:)))
        return createJoinRoomButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(ConfigureCell.self, forCellReuseIdentifier: "RoomTableViewCell")
        self.navigationItem.rightBarButtonItem = createRoomButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rooms = SharedUser.shared.user?.activeRooms ?? [Room]()
        return rooms.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoomTableViewCell", for: indexPath)
        
        if let user = SharedUser.shared.user {
            cell.textLabel?.text = user.activeRooms?[indexPath.row].roomName
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chatRoomViewController = ChatRoomViewController()
        chatRoomViewController.roomName = (SharedUser.shared.user?.activeRooms?[indexPath.row].roomName)!
        self.navigationController?.pushViewController(chatRoomViewController, animated: true)
    }
    
    @objc func createRoom(sender: UIBarButtonItem) {
        print("User wants to create a room")
        
        // The initial message and creating of text field in charge of grabbing user input
        
        let createRoomAlert = UIAlertController(title: "Enter Room Name", message: "Please enter the name of the room you'd like to join or create!", preferredStyle: .alert)
        createRoomAlert.addTextField { (roomNameTextField) in
            roomNameTextField.placeholder = "Room Name?"
        }
        
        let saveAction = UIAlertAction(title: "Create/Join Room", style: .default) { (action) in
            guard let roomName = createRoomAlert.textFields?[0].text else { return }
            
            let room = Room(roomName: roomName)
            ChatRoom.shared.joinChatroom(room: room)
            
            guard let username = Constants.userDefaults.value(forKey: "socketUsername") else { return }
            
            var message = Message(messageContent: "Any message you want!", senderUsername: username as! String, messageSender: true, roomOriginName: roomName)
            ChatRoom.shared.sendMessage(message: message)
            
            print("Name of the room user wants to create/join \(roomName)")
            SharedUser.shared.user?.activeRooms?.append(room)
            
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            print("User has canceled the action to create/join a room")
        }
        createRoomAlert.addAction(saveAction)
        createRoomAlert.addAction(cancelAction)
        self.present(createRoomAlert, animated: true, completion: nil)
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
