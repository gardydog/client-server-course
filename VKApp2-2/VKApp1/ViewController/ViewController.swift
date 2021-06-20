//
//  ViewController.swift
//  VKApp1
//
//  Created by Mac on 14.05.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: CustomButton!
    @IBOutlet weak var waitingPoint1: UIView!
    @IBOutlet weak var waitingPoint2: UIView!
    @IBOutlet weak var waitingPoint3: UIView!
    
    
    
    let fromLoginToTabBar = "fromLoginToTabBar"
    let fromLoginToError = "fromLoginToError"
    
    func animateLabelsAppearing() {     //Анимация заголовков полей заполнения
        let offset = view.bounds.width     //Присвоили ширину view -> offset
        loginLabel.transform = CGAffineTransform(translationX: -offset, y: 0)  //Убираем лэйблы с экрана
        passwordLabel.transform = CGAffineTransform(translationX: offset, y: 0)

        UIView.animate(withDuration: 1,
                       delay: 1,
                       options: .curveEaseOut,
                       animations: { [weak self] in
                        self?.loginLabel.transform = .identity       //Возвращаем в начальное положение (identity)
                        self?.passwordLabel.transform = .identity
                       }, completion: nil)
    }
    
    func animateTitleAppearing() {      //Анимация главного заголовка
        self.titleLabel.transform = CGAffineTransform(translationX: 0, y: -self.view.bounds.height/6)
        
        UIView.animate(withDuration: 1,
                       delay: 1,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0,
                       options: .curveEaseOut,
                       animations: { [weak self] in
                        self?.titleLabel.transform = .identity
                       },
                       completion: nil)
    }
    
    func animateFieldsAppearing() {     //Анимация полей заполнения с помощью layer-ов
        let fadeInAnimation = CABasicAnimation(keyPath: "opacity")
        fadeInAnimation.fromValue = 0
        fadeInAnimation.toValue = 1
        fadeInAnimation.duration = 1
        fadeInAnimation.beginTime = CACurrentMediaTime() + 1
        fadeInAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        fadeInAnimation.fillMode = CAMediaTimingFillMode.backwards //Возврат в начальное состояние
        
        self.loginTextField.layer.add(fadeInAnimation, forKey: nil)
        self.passwordTextField.layer.add(fadeInAnimation, forKey: nil)
    }
    
    func animateAuthButton() {              //Анимация кнопки входа
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0
        animation.toValue = 1
        animation.stiffness = 200       //Жесткость пружины
        animation.mass = 2
        animation.duration = 2
        animation.beginTime = CACurrentMediaTime() + 1
        animation.fillMode = CAMediaTimingFillMode.backwards
        
        self.loginButton.layer.add(animation, forKey: nil)
    }
    
    func waitingAnimation() {       //Анимация загрузки, состоящая из 3-х точек
        
        UIView.animate(withDuration: 2,
                       delay: 0,
                       options: [.repeat, .autoreverse],
                       animations: { [weak self ] in
                        self?.waitingPoint1.alpha = 0.1},
                       completion: nil)
                        
        UIView.animate(withDuration: 2,
                        delay: 1,
                        options: [.repeat, .autoreverse], animations: { [weak self ] in
                        self?.waitingPoint2.alpha = 0.1},
                        completion: nil)
        
        UIView.animate(withDuration: 2,
                        delay: 2,
                        options: [.repeat, .autoreverse], animations: { [weak self ] in
                        self?.waitingPoint3.alpha = 0.1},
                        completion: nil)
                       
    }
    
    
    //Функция вызывает анимации, которые мы прописали в animateTitlesAppearing() и т.д.
    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)
        animateLabelsAppearing()
        animateTitleAppearing()
        animateFieldsAppearing()
        animateAuthButton()
        waitingAnimation()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        waitingPoint1.layer.cornerRadius = 15  //Делаем view кружком
        waitingPoint1.layer.borderColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)  //Красим контур круга
        waitingPoint1.layer.borderWidth = 2    //Задаем ширину круга
        
        waitingPoint2.layer.cornerRadius = 15
        waitingPoint2.layer.borderColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        waitingPoint2.layer.borderWidth = 2
        
        self.waitingPoint3.layer.cornerRadius = 15  //Можно вместе с self, а можно и без него
        self.waitingPoint3.layer.borderColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        self.waitingPoint3.layer.borderWidth = 2
        
    }
    
    
    @IBAction func pressloginButton(_ sender: Any) {
        guard let login = loginTextField.text,
              let password = passwordTextField.text
              else {
            print("Empty")
            return
        }
        
        if login == "admin" || login.count >= 5,
           password == "123" || password.count >= 4 {
            performSegue(withIdentifier: fromLoginToTabBar, sender: nil)
        } else {
            performSegue(withIdentifier: fromLoginToError, sender: nil)
        }
        
    }
    

}



