
//class LoginViewController: UIViewController {
//
//    @IBOutlet weak var emailTextField: UITextField!
//    @IBOutlet weak var passwordTextField: UITextField!
//    @IBOutlet weak var loginButton: UIButton!
//    @IBOutlet weak var showHidePassButton: UIButton!
//
//    var passIsHidden = true
//    let restrictedSymbols = #",/:;<=>?[\]“‘“"_`{'|}~ "#
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        //transparent navbar self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        self.navigationController!.navigationBar.isTranslucent = true
//



//        emailTextField.delegate = self
//        passwordTextField.delegate = self
//


//        //secure pass is true
//        passwordTextField.isSecureTextEntry = true
//        showHidePassButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)

//
//        passwordTextField.isHidden = true
//        showHidePassButton.isHidden = true
//        loginButton.isHidden = true
//
//
//        //textfield padding
//        emailTextField.setLeftPaddingPoints(8)
//        emailTextField.setRightPaddingPoints(8)
//        passwordTextField.setLeftPaddingPoints(8)
//        passwordTextField.setRightPaddingPoints(8)
//
//        //prevent insertion of a word that is longer than available (by paste operation)
//        emailTextField.smartInsertDeleteType = UITextSmartInsertDeleteType.no
//        passwordTextField.smartInsertDeleteType = UITextSmartInsertDeleteType.no
//


//        passwordTextField.addTarget(self, action: #selector(LoginViewController.textFieldDidChange(_:)), for: .editingChanged)
//        emailTextField.addTarget(self, action: #selector(LoginViewController.textFieldDidChange(_:)), for: .editingChanged)
//
//        //add observers for keyboard
//        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
//
//
//    }
//
//    //MARK: - Handle soft keyboard
//
//    //hide keyboard by tap out of text field
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        view.endEditing(true)
//        super.touchesBegan(touches, with: event)
//    }
//
//    //show keyboard and scroll view up
//    @objc func keyboardWillShow(notification: NSNotification) {
//        guard let userInfo = notification.userInfo else {return}
//        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
//
//
//        let keyboardFrame = keyboardSize.cgRectValue
//        if self.view.frame.origin.y == 0 {
//            self.view.frame.origin.y -= (keyboardFrame.height - 100)
//        }
//    }
//
//
//    // hide keyboard and scroll view down
//    @objc func keyboardWillHide(notification: NSNotification) {
//        if self.view.frame.origin.y != 0 {
//            self.view.frame.origin.y = 0
//        }
//    }
//
//
//
//    //MARK: - Validation
//
//    @objc func textFieldDidChange(_ textField: UITextField) {
//
//        let minLength = 5
//        var passValid = false
//        var emailValid = false
//
//        if emailTextField.text!.count >= minLength {
//            if Validation.emailValidator(emailTextField.text!) == true {
//                emailValid = true
//                UITextView.animate(withDuration: 0.5) {
//                    self.passwordTextField.isHidden = false
//                    self.showHidePassButton.isHidden = false
//                }
//            }
//        }
//
//        if passwordTextField.text!.count >= minLength {
//            if Validation.passValidator(passwordTextField.text!) == true {
//                passValid = true
//            }
//        }
//
//        if passValid == true, emailValid == true {
//            UITextView.animate(withDuration: 0.5) {
//                self.loginButton.isHidden = false
//            }
//        }
//    }
//
//
//
//    //MARK: - Actions
//
//    @IBAction func logInButton(_ sender: Any) { }
//    @IBAction func joinCommunityButton(_ sender: Any) { }
//
//    //show/hide password
//    @IBAction func showHideButton(_ sender: Any) {
//        if(passIsHidden == false) {
//            passwordTextField.isSecureTextEntry = false
//            showHidePassButton.setImage(UIImage(systemName: "eye"), for: .normal)
//        } else {
//            passwordTextField.isSecureTextEntry = true
//            showHidePassButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
//        }
//        passIsHidden = !passIsHidden
//    }
//
//}
//
//
//
//
//extension LoginViewController: UITextFieldDelegate {
//
//    //MARK: - Handle Done/Return button
//    //hide keyboard by click on "done"/"return" button
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//
//        return true
//    }
//
//
//    //MARK: - Check email, password for max length & remove restricted symbols
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        guard let textFieldText = textField.text, let rangeOfTextToReplace = Range(range, in: textFieldText) else { return false }
//        let substringToReplace = textFieldText[rangeOfTextToReplace]
//        let count = textFieldText.count - substringToReplace.count + string.count
//
//        switch textField {
//
//        case emailTextField:
//            guard let email = emailTextField.text else { return false }
//            if email.contains("@") {
//                return preventRepeatingAtSymbol(string)
//            }
//            if email.count <= 25 {
//                return preventInputRestrictedSymbols(string, textField)
//            }
//        case passwordTextField:
//            return count <= 20 && preventInputRestrictedSymbols(string, textField)
//        default:
//            return false
//        }
//        return true
//    }
//
//
//
//   func preventRepeatingAtSymbol(_ string: String) -> Bool {
//       // prevent enter more than one "@" in email field
//    return string.rangeOfCharacter(from: CharacterSet(charactersIn: "@" + restrictedSymbols)) == nil
//    }
//
//
//
//
//    //MARK: - Prevent input restricted symbols
//    func preventInputRestrictedSymbols(_ string: String, _ textField: UITextField) -> Bool {
//        switch textField {
//        case emailTextField:
//            return string.rangeOfCharacter(from: CharacterSet(charactersIn: restrictedSymbols)) == nil
//        case passwordTextField:
//            return string.rangeOfCharacter(from: CharacterSet(charactersIn: "." + restrictedSymbols)) == nil
//        default:
//            return false
//        }
//    }
//
//
//}
//
//
//
//
//
//
