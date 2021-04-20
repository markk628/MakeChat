//
//  CreateUserView.swift
//  Make-ChatRooms-StarterKit
//
//  Created by Matthew Harrilal on 2/18/19.
//  Copyright © 2019 Matthew Harrilal. All rights reserved.
//

import UIKit

class CreateUserView: UIView {
    
    lazy var makeSchoolLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "MakeSchoolLogo copy")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
        
    lazy var userNameTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Chatroom Username"
        textfield.textAlignment = .center
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    lazy var joinChatRoomButton: UIButton = {
        let button = UIButton()
        button.setTitle("Join Chatroom", for: .normal)
        button.addTarget(self, action: #selector(joinChatRoomButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        self.backgroundColor = .clear
        self.addSubview(makeSchoolLogoImageView)
        self.addSubview(userNameTextField)
        self.addSubview(joinChatRoomButton)
        
        NSLayoutConstraint.activate([
            makeSchoolLogoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            makeSchoolLogoImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 100),
            makeSchoolLogoImageView.widthAnchor.constraint(equalToConstant: 240),
            makeSchoolLogoImageView.heightAnchor.constraint(equalToConstant: 240),
            
            userNameTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            userNameTextField.topAnchor.constraint(equalTo: makeSchoolLogoImageView.bottomAnchor, constant: 100),
            userNameTextField.widthAnchor.constraint(equalToConstant: 191),
            userNameTextField.heightAnchor.constraint(equalToConstant: 34),
            
            joinChatRoomButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            joinChatRoomButton.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: 124),
            joinChatRoomButton.widthAnchor.constraint(equalToConstant: 120),
            joinChatRoomButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    @objc private func joinChatRoomButtonTapped() {
        guard let username = userNameTextField.text else {return}
        let user = User(username: username, activeRooms: nil)
        ChatRoom.shared.sendUsername(user: user)
    }
}
