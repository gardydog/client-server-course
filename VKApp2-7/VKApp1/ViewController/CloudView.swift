//
//  CloudView.swift
//  VKApp1
//
//  Created by Mac on 06.06.2021.
//

import UIKit

class CloudView: UIView {       //Отрисовка картинки в ViewController-е при неверном вводе данных

    override func draw(_ rect: CGRect) {
        
        super.draw(rect)
        guard let context = UIGraphicsGetCurrentContext() else {return}
        context.setStrokeColor(UIColor.green.cgColor)
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 210, y: 120))       //Начинаем с самой верхней вершины рисовать
        path.addLine(to: CGPoint(x: 215, y: 140))
        path.addLine(to: CGPoint(x: 235, y: 140))
        path.addLine(to: CGPoint(x: 220, y: 150))
        path.addLine(to: CGPoint(x: 230, y: 170))
        path.addLine(to: CGPoint(x: 210, y: 155))
        path.addLine(to: CGPoint(x: 190, y: 170))
        path.addLine(to: CGPoint(x: 200, y: 150))
        path.addLine(to: CGPoint(x: 185, y: 140))
        path.addLine(to: CGPoint(x: 205, y: 140))
        path.close()
        path.stroke()
        
        //MARK: - Рисует шарик, который двигается по контору нарисованной выше фигуры -
        let customLayer = CAShapeLayer()
        customLayer.bounds = CGRect(x: 0, y: 0, width: 10, height: 10)
        customLayer.position = CGPoint(x: 40, y: 20)    //Не очень важный параметр
        customLayer.cornerRadius = 5
        customLayer.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1).cgColor
        
        let pathAnime = CAKeyframeAnimation(keyPath: "position")
        pathAnime.path = path.cgPath
        pathAnime.calculationMode = CAAnimationCalculationMode.cubicPaced
        pathAnime.speed = 0.1
        pathAnime.repeatCount = Float.infinity

        customLayer.add(pathAnime, forKey: nil)

        self.layer.addSublayer(customLayer)
        
        
        
    }

    
    
    
}
