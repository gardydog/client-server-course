//
//  CustomButton.swift
//  VKApp1
//
//  Created by Mac on 28.05.2021.
//

import UIKit

class CustomButton: UIButton {
    @IBInspectable var borderColor: UIColor = .orange
    @IBInspectable var borderWidth: CGFloat = 2
    
    override func awakeFromNib() {
        self.layer.cornerRadius = self.frame.height / 2 //Делаем круглую рамку аватарки
        self.layer.masksToBounds = true     //Обрезает лишние куски картинки до границ иконки
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        
        
    }
    
//    let gradientLayer = CAGradientLayer()
//    gradientLayer.colors = [UIColor.systemTeal.cgColor, UIColor.systemBlue.cgColor, UIColor.systemPink.cgColor]
//    gradientLayer.locations = [0, 0.5, 1]
//    gradientLayer.startPoint = CGPoint.zero
//    gradientLayer.endPoint = CGPoint(x: 0, y: 1)
//    gradientLayer.frame =
    
    
    
    
}
