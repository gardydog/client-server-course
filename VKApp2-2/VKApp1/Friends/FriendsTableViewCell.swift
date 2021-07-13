//
//  FriendsTableViewCell.swift
//  VKApp1
//
//  Created by Mac on 22.05.2021.
//

import UIKit

class FriendsTableViewCell: UITableViewCell {

    var savedObject: Any?
    
    var isTapped: Bool = true

    @IBOutlet weak var fritendAvatarImage: UIImageView!
    @IBOutlet weak var friendNameLabel: UILabel!
    @IBOutlet weak var avatarShadow: AvatarShadow!
    @IBOutlet weak var stackView: UIStackView!
    
    
    func clearCell() {
        fritendAvatarImage.image = nil
        friendNameLabel.text = nil
        savedObject = nil
    }
    
    override func prepareForReuse() {
        clearCell()
    }
    
    func configure(user: User) {
        fritendAvatarImage.image = user.avatar
        friendNameLabel.text = user.fullName
        savedObject = user

    }
    
    func tapOnAvatarAnimation() {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0.9
        animation.toValue = 1
        animation.stiffness = 70      //Жесткость пружины
        animation.mass = 2
        animation.duration = 1
        animation.beginTime = CACurrentMediaTime()
        animation.fillMode = CAMediaTimingFillMode.backwards
        
        self.avatarShadow.layer.add(animation, forKey: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(onTap))
        recognizer.numberOfTapsRequired = 1
        recognizer.numberOfTouchesRequired = 1
//        avatarShadow.isUserInteractionEnabled = true  //не потребовались
//        stackView.isUserInteractionEnabled = true
        avatarShadow.addGestureRecognizer(recognizer)
    }
    
    //MARK: - Метод распознает нажатия  -
    @objc func onTap() {
        if isTapped {
            tapOnAvatarAnimation()
            isTapped = false
           
        } else {
            tapOnAvatarAnimation()
            isTapped = true
        }
    }
    
    
    
}
