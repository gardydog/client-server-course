//
//  FriendsCollectionViewCell.swift
//  VKApp1
//
//  Created by Mac on 22.05.2021.
//

import UIKit

class FriendsCollectionViewCell: UICollectionViewCell {
    
    var isTapped: Bool = true
    
    @IBOutlet weak var friendsPhotoImage: UIImageView!
    @IBOutlet weak var likeNumberLabel: UILabel!
    @IBOutlet weak var likeImageView: UIImageView!
    @IBOutlet weak var cheatView: UIView!
    
    func tapOnLikeImageAnimation(_ count: String) {        //Анимация нажатия на сердечко (Ставим лайк)
        
        UIView.transition(with: likeImageView,
                          duration: 0.3,
                          options: [.transitionFlipFromLeft],
                          animations: { [weak self] in
                            self?.likeImageView.image = UIImage(systemName: "heart.fill")
                            self?.likeNumberLabel.text = count
                          }, completion: nil)
    }
    
    func tapOffLikeImageAnimation(_ count: String) {       //Анимация нажатия на сердечко (Убираем лайк)
        
        UIView.transition(with: likeImageView,
                          duration: 0.4,
                          options: [.transitionCrossDissolve],
                          animations: { [weak self] in
                            self?.likeImageView.image = UIImage(systemName: "heart")
                            self?.likeNumberLabel.text = count
                          }, completion: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        likeNumberLabel.text = "0"

        let recognizer = UITapGestureRecognizer(target: self, action: #selector(onTap))
        recognizer.numberOfTapsRequired = 1
        recognizer.numberOfTouchesRequired = 1
        cheatView.addGestureRecognizer(recognizer)
    }
    
    //MARK: - Метод распознает нажатия на cheatView (выше) -
    @objc func onTap() {
        if isTapped {
           // tapOnLikeImageAnimation()
            tapOnLikeImageAnimation(String(Int(likeNumberLabel.text!)! + 1))
            //likeNumberLabel.text = "1"
            likeNumberLabel.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)  //При нажатии лайка, счетчик становится красного цвета
            isTapped = false
           
        } else {
            //tapOffLikeImageAnimation()
            tapOffLikeImageAnimation(String(Int(likeNumberLabel.text!)! - 1))
            //likeNumberLabel.text = "0"
            likeNumberLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            isTapped = true
        }
    }
    
    func clearCell() {
        friendsPhotoImage.image = nil
    }
    
    override func prepareForReuse() {
       clearCell()
    }
    
    func configure(photoImage: PhotoItemsCodable) {
        if photoImage.likes.userLikes > 0 {
            isTapped = true
            likeImageView.image = UIImage(systemName: "heart.fill")
        }
        
        for photoArray in photoImage.sizes {
            if photoArray.type == "m" {
                friendsPhotoImage.sd_setImage(with: URL(string: photoArray.url))
                likeNumberLabel.text = String(photoImage.likes.count)
                
            }
        }
    }
    
}
