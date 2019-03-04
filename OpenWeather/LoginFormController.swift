//
//  LoginFormController.swift
//  OpenWeather
//
//  Created by Виктор Марусин on 28.02.2019.
//  Copyright © 2019 Blackwood Studio. All rights reserved.
//

import UIKit

class LoginFormController: UIViewController {
    
    @IBOutlet weak var loginInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //жест нажатия
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        //присваеваем его UIScrollView
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Подписываемся на два уведомления: Одно приходит при появлении клавиатуры
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWasShown(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        //Второе когда она пропадает
        NotificationCenter.default.addObserver(self,
                                               selector:#selector(keyboardWillHidden(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //Отписываемся от уведомлений когда они не нужны
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
    }
    
    
    // MARK: - Actions
    @IBAction func loginButtonPressed(_ sender: Any) {
        
        guard let login = loginInput.text, let password = passwordInput.text else {
            return
        }
        
        if login == "admin" && password == "123" {
            print("успешная регистрация")
        }else {
            print("неуспешная регистрация")
        }
    }
    
    // MARK: - Когда клавиатура появляется
    @objc func keyboardWasShown(notification: Notification) {
        //получаем рзамер клавиатуры
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: kbSize.height, right: 0)
        
        //Добавляем отступ внизу UIScrollView равный размеру клавиатуры
        self.scrollView?.contentInset = contentInset
        scrollView?.scrollIndicatorInsets = contentInset
    }
    
    // MARK: - Когда клавиатура исчезает
    @objc func keyboardWillHidden(notification: Notification) {
        let contentInset = UIEdgeInsets.zero
        scrollView?.contentInset = contentInset
        scrollView?.scrollIndicatorInsets = contentInset
    }
    
    @objc func hideKeyboard() {
        self.scrollView.endEditing(true)
    }
}
