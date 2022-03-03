//
//  ConfirmEmailViewController.swift
//  BreweryBees
//
//  Created by Paulo Henrique Bendazzoli on 28/02/22.
//
import UIKit

class ConfirmEmailViewController: UIViewController {
    
    var isSelected = false
    
    private enum Constants {
        static let title = "email.confirm.title"
        static let description = "email.confirm.description"
        static let emailFieldPlaceholder = "email.confirm.emailField.placeholder"
        static let checkboxDescription = "email.confirm.checkbox.description"
        static let confirmButtonText = "email.confirm.button.text"
        static let ratedBreweriesNavBarTitle = "rated.navigationBar.title"
    }
    
    let saveEmailKey = "emailSaved"
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        self.view.addSubview(background)
        self.view.addSubview(titleLabel)
        self.view.addSubview(descriptionLabel)
        self.view.addSubview(emailField)
        self.view.addSubview(selectButton)
        self.view.addSubview(rememberEmailLabel)
        self.view.addSubview(confirmButton)
        
        if let email: String = UserDefaults.standard.object(forKey: saveEmailKey) as? String {
            if email != "" {
                emailField.text = email
                isSelected = true
                self.selectButton.setBackgroundImage(UIImage(named: "select"), for: .normal)
                textFieldShouldReturn(emailField)
            }
        }
        
        generateConstraints()
    }
    
    lazy var background: UIImageView  = {
        let view = UIImageView()
        view.image = UIImage(named: "bgYellow")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleLabel: UILabel = {
       let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = Constants.title.localized
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont(name: "Quicksand-Bold", size: 18)
        
        return titleLabel
    }()
    
    let descriptionLabel: UILabel = {
       let descriptionLabel = UILabel()
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text = Constants.description.localized
        descriptionLabel.textAlignment = .left
        descriptionLabel.font = UIFont(name: "Quicksand-Regular", size: 16)
        descriptionLabel.numberOfLines = 3
        
        return descriptionLabel
    }()
    
    lazy var emailField: UITextField = {
        let emailField = UITextField()
        emailField.placeholder = Constants.emailFieldPlaceholder.localized
        emailField.translatesAutoresizingMaskIntoConstraints = false
        emailField.textAlignment = .left
        emailField.delegate = self
        emailField.font = UIFont(name: "Quicksand-Regular", size: 16)
        emailField.leftViewMode = UITextField.ViewMode.always
        
        return emailField
    }()
    
    let selectButton: UIButton = {
        let selectButton = UIButton()
        selectButton.setBackgroundImage(UIImage(named: "unselected"), for: .normal)
        selectButton.translatesAutoresizingMaskIntoConstraints = false
        selectButton.addTarget(self, action: #selector(onButtonSelect), for: .touchUpInside)
        
        return selectButton
    }()
    
    let rememberEmailLabel: UILabel = {
      let rememberEmailLabel = UILabel()
        rememberEmailLabel.text = Constants.checkboxDescription.localized
        rememberEmailLabel.translatesAutoresizingMaskIntoConstraints = false
        rememberEmailLabel.textAlignment = .left
        rememberEmailLabel.font = UIFont(name: "Quicksand-Light", size: 14)
        
        return rememberEmailLabel
    }()
    
    let confirmButton: UIButton = {
       let confirmButton = UIButton()
        confirmButton.setTitle(Constants.confirmButtonText.localized, for: .normal)
        confirmButton.setTitleColor(.black, for: .normal)
        confirmButton.backgroundColor = UIColor(named: "yellow")
        confirmButton.layer.cornerRadius = 5
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        confirmButton.isEnabled = false
        confirmButton.layer.opacity = 0.3
        confirmButton.addTarget(self, action: #selector(confirmButtonClick), for: .touchUpInside)
        
        return confirmButton
    }()
    
    // MARK: selectors
    @objc func onButtonSelect() {
        if !isSelected {
            self.selectButton.setBackgroundImage(UIImage(named: "select"), for: .normal)
            self.isSelected = true
            UserDefaults.standard.set(emailField.text, forKey: saveEmailKey)
        }
        else {
            self.selectButton.setBackgroundImage(UIImage(named: "unselected"), for: .normal)
            self.isSelected = false
            UserDefaults.standard.set("", forKey: saveEmailKey)
        }
    }
    
    @objc func confirmButtonClick() {
        let ratedBreweryViewController = RatedBreweryViewController()
        ratedBreweryViewController.email = emailField.text ?? ""
        let backItem = UIBarButtonItem()
        backItem.title = Constants.ratedBreweriesNavBarTitle.localized
        navigationItem.backBarButtonItem = backItem
        navigationController?.navigationBar.tintColor = UIColor(named: "YellowBees")
        navigationController?.pushViewController(ratedBreweryViewController, animated: true)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func generateConstraints() {
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: view.topAnchor),
            background.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            background.heightAnchor.constraint(equalToConstant: 200),
            
            titleLabel.topAnchor.constraint(equalTo: super.view.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: super.view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: super.view.trailingAnchor, constant: -16),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            emailField.topAnchor.constraint(equalTo: background.bottomAnchor, constant: 24),
            emailField.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            emailField.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor),
            
            selectButton.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 20),
            selectButton.leadingAnchor.constraint(equalTo: emailField.leadingAnchor),
            selectButton.heightAnchor.constraint(equalToConstant: 17),
            selectButton.widthAnchor.constraint(equalToConstant: 17),
            
            rememberEmailLabel.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 20),
            rememberEmailLabel.leftAnchor.constraint(equalTo: selectButton.rightAnchor, constant: 5),
            
            confirmButton.topAnchor.constraint(equalTo: rememberEmailLabel.bottomAnchor, constant: 28),
            confirmButton.leadingAnchor.constraint(equalTo: emailField.leadingAnchor),
            confirmButton.trailingAnchor.constraint(equalTo: emailField.trailingAnchor),
            confirmButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}

extension ConfirmEmailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ emailField: UITextField) -> Bool {
        //textField code
        let textfield = emailField.text ?? "?"
        if  isValidEmail(textfield) {
            self.confirmButton.isEnabled = true
            self.confirmButton.layer.opacity = 1
            if isSelected {
                UserDefaults.standard.set(emailField.text, forKey: saveEmailKey)
            }
        } else {
            self.confirmButton.isEnabled = false
            self.confirmButton.layer.opacity = 0.3
        }
        emailField.resignFirstResponder()
        return true
    }
}
