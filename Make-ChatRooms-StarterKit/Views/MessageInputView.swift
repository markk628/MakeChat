//
//  MessageInputView.swift
//  Make-ChatRooms-StarterKit
//
//  Created by Mark Kim on 4/10/21.
//  Copyright © 2021 Matthew Harrilal. All rights reserved.
//

import UIKit

class MessageInputView: UIView {
    
    let textView = UITextView()
    let sendButton = UIButton()
    var delegate: MessageInputDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func sendButtonTapped() {
        guard let message = textView.text else { return }
        print("User has typed in the message \(String(describing: message))")
        
        textView.text = ""
        delegate?.sendWasTapped(message: message)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let size = bounds.size
        
        textView.bounds = CGRect(x: 0, y: 0, width: size.width - 32 - 8 - 60, height: 40)
        sendButton.bounds = CGRect(x: 0, y: 0, width: 60, height: 44)
        
        textView.center = CGPoint(x: textView.bounds.size.width/2.0 + 16, y: bounds.size.height/2.0)
        sendButton.center = CGPoint(x: bounds.size.width - 30 - 16, y: bounds.size.height/2.0)
    }
    
    func configureViews() {
        backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1.0)
        textView.layer.cornerRadius = 4
        textView.layer.borderColor = UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 0.6).cgColor
        textView.layer.borderWidth = 1
        
        sendButton.backgroundColor = UIColor(red: 8/255, green: 183/255, blue: 231/255, alpha: 1.0)
        sendButton.layer.cornerRadius = 4
        sendButton.setTitle("Send", for: .normal)
        sendButton.isEnabled = true
        
        sendButton.addTarget(self, action: #selector(MessageInputView.sendButtonTapped), for: .touchUpInside)
        
        addSubview(textView)
        addSubview(sendButton)
    }
}

extension MessageInputView: UITextViewDelegate {
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        return true
    }
}
