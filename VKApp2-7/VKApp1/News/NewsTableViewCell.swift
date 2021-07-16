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
    
    func tapOnLikeImageAnimation(_ count: String) {  //Анимация нажатия на сердечко (Ставим лайк)
        
        UIView.transition(with: likeImage,
                          duration: 0.3,
                          options: [.transitionFlipFromLeft],
                          animations: { [weak self] in
                            self?.likeImage.image = UIImage(systemName: "heart.fill")
                            self?.likeLabel.text = count
                          }, completion: nil)
    }
    
    func tapOffLikeImageAnimation(_ count: String) {     //Анимация нажатия на сердечко (Убираем лайк)
        
        UIView.transition(with: likeImage,
                          duration: 0.4,
                          options: [.transitionCrossDissolve],
                          animations: { [weak self] in
                            self?.likeImage.image = UIImage(systemName: "heart")
                            self?.likeLabel.text = count
                          }, completion: nil)
    }
    
    func tapOnCommentAnimation(_ count: String) {                  //Анимация нажатия на комментарий
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0.85
        animation.toValue = 1
        animation.stiffness = 70      //Жесткость пружины
        animation.mass = 2
        animation.duration = 1
        animation.beginTime = CACurrentMediaTime()
        animation.fillMode = CAMediaTimingFillMode.backwards
        
        self.commentTextLabel.text = count
        self.commentImage.layer.add(animation, forKey: nil)
    }
    
    func tapOnShareAnimation(_ count: String) {                  //Анимация нажатия на "поделиться"
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0.85
        animation.toValue = 1
        animation.stiffness = 70      //Жесткость пружины
        animation.mass = 2
        animation.duration = 1
        animation.beginTime = CACurrentMediaTime()
        animation.fillMode = CAMediaTimingFillMode.backwards
        
        self.shareLabel.text = count
        self.shareImage.layer.add(animation, forKey: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
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
            tapOnLikeImageAnimation(String(Int(likeLabel.text!)! + 1))
            likeLabel.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)  //При нажатии лайка, счетчик становится красного цвета
            isTapped = false

        } else {
            tapOffLikeImageAnimation(String(Int(likeLabel.text!)! - 1))
            likeLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            isTapped = true
        }
    }
    
    @objc func onTapOnComment() {
        if isTapped {
            tapOnCommentAnimation(String(Int(commentTextLabel.text!)! + 1))
            isTapped = false

        } else {
            tapOnCommentAnimation(String(Int(commentTextLabel.text!)! - 1))
            isTapped = true
        }
    }
    
    @objc func onTapOnShare() {
        if isTapped {
            tapOnShareAnimation(String(Int(shareLabel.text!)! + 1))
            isTapped = false

        } else {
            tapOnShareAnimation(String(Int(shareLabel.text!)! - 1))
            isTapped = true
        }
    }
    
    func clearCell() {
        newsImage.image = nil
        newsTextLabel.text = nil
        likeLabel.text = nil
        likeImage.image = nil
        commentTextLabel.text = nil
        commentImage.image = nil
        shareLabel.text = nil
        shareImage.image = nil
        eyeLabel.text = nil
        eyeImage.image = nil
    }
    
    override func prepareForReuse() {
       clearCell()
    }
    
    func configure(news: FirebaseNewsModel) {
        if let image = news.urlImage {
        newsImage.sd_setImage(with: URL(string: image))
        }
        
        if let newsText = news.text {
            newsTextLabel.text = newsText
        }
        
        likeLabel.text = String(news.likesCount)
        likeImage.image = UIImage(systemName: "heart")
        commentTextLabel.text = String(news.commentsCount)
        commentImage.image = UIImage(systemName: "bubble.left")
        shareLabel.text = String(news.repostsCount)
        shareImage.image = UIImage(systemName: "arrowshape.turn.up.right")
        eyeLabel.text = String(news.viewsCount)
        eyeImage.image = UIImage(systemName: "eye")
        
        if news.userLikes > 0 {
            isTapped = true
            likeImage.image = UIImage(systemName: "heart.fill")
        }

    }
    
    
    
}
