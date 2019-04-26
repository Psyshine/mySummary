//
//  ViewController.swift
//  mySummary
//
//  Created by Андрей Прокопенко on 4/26/19.
//  Copyright © 2019 Andry Pro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let login = "1"
    let password = "2"
    
    @IBOutlet weak var mainScrollViev: UIScrollView!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerKeyboardNotifikations()
        self.hideKeyboard()
    }
    deinit {
        removeKeyboardNotifikations()
    }
    
    @IBAction func loginButton(_ sender: Any) {
        if loginTextField.text! == login && passwordTextField.text! == password {
            performSegue(withIdentifier: "CorrectPasswordSeque", sender: nil)
        } else {
            performSegue(withIdentifier: "WrongPassworSeque", sender: nil)
        }
   loginTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    } // Выбираем на какой VC перейти. Если логин и пароль верны то сразу на summaryVC
}

extension ViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        case "WrongPassworSeque":
            prepareForShowingWrongPasvordVC(segue: segue, sender: sender)
        case "ForgotPasswordSegue":
            prepareForShowingForgotLoginVC(segue: segue, sender: sender)
        case "ForgotLoginSegue":
            prepareForShowingForgotPasswordVC(segue: segue, sender: sender)
        default:
            return
        }
    } // В зависимости от идентификатора сигвея, готовим переход на wrongPaswordVC и передаем в него данные
    
    func prepareForShowingForgotLoginVC(segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! WrongAutorizationViewController
        destination.labelText = "Your login is: \(login)"
    }
    
    func prepareForShowingForgotPasswordVC(segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! WrongAutorizationViewController
        destination.labelText = "Your password is: \(password)"
    }
    
    func prepareForShowingWrongPasvordVC(segue: UIStoryboardSegue, sender: Any?) {
        let loginAndPassword = (loginTextField.text, passwordTextField.text)
        
        switch loginAndPassword {
        case ("", _):
            showAlert(empty: "login")
        case (_, ""):
            showAlert(empty: "password")
        case (login, password):
            let destination = segue.destination as! SummaryViewController
            destination.navigationItem.title = "Good!"
        case (_, password):
            let destination = segue.destination as! WrongAutorizationViewController
            destination.navigationItem.title = "Wrong login"
            destination.labelText = "Wrong login! If you forgot your login click \"Forgot login?\""
        case (login, _):
            let destination = segue.destination as! WrongAutorizationViewController
            destination.navigationItem.title = "Wrong password"
            destination.labelText = "Wrong password! If you forgot your password click \"Forgot password?\""
        default:
            let destination = segue.destination as! WrongAutorizationViewController
            destination.navigationItem.title = "Wrong password and login"
            destination.labelText = "Wrong login and password! If you forgot your login and password, you are very forgetful!"
        }
    }
    
    func showAlert(empty: String){
        let alert = UIAlertController(title: "Wrong \(empty)!",
            message: "Please enter your \(empty)!",
            preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK",
                                     style: .default,
                                     handler: nil)
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    @IBAction func unwind(seque: UIStoryboardSegue) {
    }
   
    func registerKeyboardNotifikations() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeKeyboardNotifikations() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        let userInfo = notification.userInfo
        if let keyboardSize = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            mainScrollViev.contentOffset = CGPoint(x: 0, y: keyboardSize.height)
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        let userInfo = notification.userInfo
        if ((userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            mainScrollViev.contentOffset = CGPoint.zero
        }
    }
    
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(self.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
}







