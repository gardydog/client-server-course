//
//  AvatarImageView.swift
//  VKApp1
//
//  Created by Mac on 25.05.2021.
//

import UIKit

class AvatarImage: UIImageView {        //Кастомизация картинки
    @IBInspectable var borderColor: UIColor = .gray //Цвет границ иконки с фотографией
    @IBInspectable var borderWidth: CGFloat = 1   //Толщина границ иконки с фотографией
    
    override func awakeFromNib() {
        self.layer.cornerRadius = self.frame.height / 2 //Делаем круглую рамку аватарки
        self.layer.masksToBounds = true     //Обрезает лишние куски картинки до границ иконки
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
    }
}

class AvatarShadow: UIView {        //Кастомизация тени
    @IBInspectable var shadowColor: UIColor = .lightGray    //Цвет тени от элементов
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 0.0, height: -3)    //направление и глубина тени
    @IBInspectable var shadowOpacity: Float = 0.8   //Прозрачность тени
    @IBInspectable var shadowRadius: CGFloat = 3    //Распространение тени по периметру view
    
    override func awakeFromNib() {
        self.backgroundColor = .clear   //Цвет фона бэкграунда
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRadius
    }
}
