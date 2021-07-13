//
//  NewsTableViewCell.swift
//  VKApp1
//
//  Created by Mac on 01.06.2021.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    var isTapped: Bool = true
    
    @IBOutlet weak var newsTextLabel: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var likeImageCheatView: UIView!
    @IBOutlet weak var commentTextLabel: UILabel!
    @IBOutlet weak var commentImage: UIImageView!
    @IBOutlet weak var commentImageCheatView: UIView!
    @IBOutlet weak var shareLabel: UILabel!
    @IBOutlet weak var shareImage: UIImageView!
    @IBOutlet weak var shareImageCheatView: UIView!
    @IBOutlet weak var eyeLabel: UILabel!
    @IBOutlet weak var eyeImage: UIImageView!
    
    func tapOnLikeImageAnimation() {                 //Анимация нажатия на сердечко (Ставим лайк)
        
        UIView.transition(with: likeImage,
                          duration: 0.3,
                          options: [.transitionFlipFromLeft],
                          animations: { [weak self] in
                            self?.likeImage.image = UIImage(systemName: "heart.fill")
                          }, completion: nil)
    }
    
    func tapOffLikeImageAnimation() {                //Анимация нажатия на сердечко (Убираем лайк)
        
        UIView.transition(with: likeImage,
                          duration: 0.4,
                          options: [.transitionCrossDissolve],
                          animations: { [weak self] in
                            self?.likeImage.image = UIImage(systemName: "heart")
                          }, completion: nil)
    }
    
    func tapOnCommentAnimation() {                  //Анимация нажатия на комментарий
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0.85
        animation.toValue = 1
        animation.stiffness = 70      //Жесткость пружины
        animation.mass = 2
        animation.duration = 1
        animation.beginTime = CACurrentMediaTime()
        animation.fillMode = CAMediaTimingFillMode.backwards
        
        self.commentImage.layer.add(animation, forKey: nil)
    }
    
    func tapOnShareAnimation() {                  //Анимация нажатия на "поделиться"
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0.85
        animation.toValue = 1
        animation.stiffness = 70      //Жесткость пружины
        animation.mass = 2
        animation.duration = 1
        animation.beginTime = CACurrentMediaTime()
        animation.fillMode = CAMediaTimingFillMode.backwards
        
        self.shareImage.layer.add(animation, forKey: nil)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        likeLabel.text = "0"
        commentTextLabel.text = "0"
        shareLabel.text = "0"
        eyeLabel.text = "0"
        
        let templateLabel = UILabel.appearance()     //Метод, который позволяет редактировать надпись (UILabel)
        templateLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)

        let recognizer = UITapGestureRecognizer(target: self, action: #selector(onTap))
        recognizer.numberOfTapsRequired = 1
        recognizer.numberOfTouchesRequired = 1
        likeImageCheatView.addGestureRecognizer(recognizer)                         //Для лайка
        
        let recognizerForComment = UITapGestureRecognizer(target: self, action: #selector(onTapOnComment))
        recognizer.numberOfTapsRequired = 1
        recognizer.numberOfTouchesRequired = 1
        commentImageCheatView.addGestureRecognizer(recognizerForComment)            //Для комментариев
        
        let recognizerForShare = UITapGestureRecognizer(target: self, action: #selector(onTapOnShare))
        recognizer.numberOfTapsRequired = 1
        recognizer.numberOfTouchesRequired = 1
        shareImageCheatView.addGestureRecognizer(recognizerForShare)                //Для "поделиться"
    }
    
    //MARK: - Метод распознает нажатия на cheatView (выше) -
    @objc func onTap() {
        if isTapped {
            tapOnLikeImageAnimation()
            likeLabel.text = "1"
            likeLabel.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)  //При нажатии лайка, счетчик становится красного цвета
            eyeLabel.text = "1"
            isTapped = false

        } else {
            tapOffLikeImageAnimation()
            likeLabel.text = "0"
            likeLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            isTapped = true
        }
    }
    
    @objc func onTapOnComment() {
        if isTapped {
            tapOnCommentAnimation()
            commentTextLabel.text = "1"
            eyeLabel.text = "1"
            isTapped = false

        } else {
            tapOnCommentAnimation()
            commentTextLabel.text = "0"
            isTapped = true
        }
    }
    
    @objc func onTapOnShare() {
        if isTapped {
            tapOnShareAnimation()
            shareLabel.text = "1"
            eyeLabel.text = "1"
            isTapped = false

        } else {
            tapOnShareAnimation()
            shareLabel.text = "0"
            isTapped = true
        }
    }
    
    
    func clearCell() {
        newsImage.image = nil
    }
    
    override func prepareForReuse() {
       clearCell()
    }
    
    func configure(newsText: String, newsPhotoImage: UIImage?) {
        newsTextLabel.text = newsText
        newsImage.image = newsPhotoImage
    }
    
}
