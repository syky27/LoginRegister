//
//  ViewController.swift
//  LoginScreen
//
//  Created by Tomas Sykora, jr. on 06/11/2016.
//  Copyright © 2016 AJTY, s.r.o. All rights reserved.
//

import UIKit

import SkyFloatingLabelTextField


class ViewController: UIViewController {
	let loginView = UIView()
	let registerView = UIView()
	let loginLabel = UILabel()
	let registerLabel = UILabel()

	var loginSelected = NSLayoutConstraint()
	var registerSelected = NSLayoutConstraint()
	var loginHorizontalConstraint = NSLayoutConstraint()
	var registerHorizontalConstraint = NSLayoutConstraint()

	let imageViewLogin = UIImageView(image: #imageLiteral(resourceName: "optify"))
	let imageViewRegister = UIImageView(image: #imageLiteral(resourceName: "newbie"))

	let loginUsername = SkyFloatingLabelTextFieldWithIcon()
	let loginPassword = SkyFloatingLabelTextFieldWithIcon()
	let registerUsername = SkyFloatingLabelTextFieldWithIcon()
	let registerPassword = SkyFloatingLabelTextFieldWithIcon()

	let loginButton = UIButton()
	let registerButton = UIButton()


	func setGestureRecognizers() {
		let registerGesture = UITapGestureRecognizer(target: self, action:  #selector (self.registerTapped))
		self.registerView.addGestureRecognizer(registerGesture)

		let loginGesture = UITapGestureRecognizer(target: self, action:  #selector (self.loginTapped))
		self.loginView.addGestureRecognizer(loginGesture)
	}

	func addSubviews(){
		loginView.translatesAutoresizingMaskIntoConstraints = false
		registerView.translatesAutoresizingMaskIntoConstraints = false
		loginLabel.translatesAutoresizingMaskIntoConstraints = false
		registerLabel.translatesAutoresizingMaskIntoConstraints = false

		view.addSubview(loginView)
		view.addSubview(registerView)
		view.addSubview(loginLabel)
		view.addSubview(registerLabel)
	}


	func keyboardWillShow(notification: NSNotification) {
		if !self.loginHorizontalConstraint.isActive {
			NSLayoutConstraint.activate([self.loginHorizontalConstraint, self.registerHorizontalConstraint])
			self.view.layoutIfNeeded()
		}
	}

	func keyboardWillHide(notification: NSNotification) {
		if self.loginHorizontalConstraint.isActive {
			NSLayoutConstraint.deactivate([self.loginHorizontalConstraint, self.registerHorizontalConstraint])
			self.view.layoutIfNeeded()
		}
		
	}

	func setNotifications() {
		NotificationCenter.default.addObserver(self,
		                                       selector: #selector(ViewController.keyboardWillShow),
		                                       name: NSNotification.Name.UIKeyboardWillShow,
		                                       object: nil)

		NotificationCenter.default.addObserver(self,
		                                       selector: #selector(ViewController.keyboardWillHide),
		                                       name: NSNotification.Name.UIKeyboardWillHide,
		                                       object: nil)
	}

	func setBlur() {
		let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.extraLight)
		let blurEffectView = UIVisualEffectView(effect: blurEffect)
		blurEffectView.frame = view.bounds
		blurEffectView.alpha = 0.4
		blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
		view.addSubview(blurEffectView)

		view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "glasses"))
	}


	override func viewDidLoad() {
		super.viewDidLoad()
		setNotifications()
		setBlur()
		addSubviews()
		setGestureRecognizers()

		loginLabel.text = "LOGIN"
		loginLabel.textColor = .white
		registerLabel.text = "REGISTER"
		registerLabel.textColor = .white
		registerLabel.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)

		loginView.backgroundColor = UIColor(red: (64/255.0), green: (54/255.0), blue: (105/255.0), alpha: 0.6)
		registerView.backgroundColor = UIColor(red: (64/255.0), green: (54/255.0), blue: (160/255.0), alpha: 0.7)


		loginUsername.setOptify(type: .username)
		loginPassword.setOptify(type: .password)
		registerUsername.setOptify(type: .username)
		registerPassword.setOptify(type: .password)


		loginUsername.delegate = self
		loginPassword.delegate = self

		registerUsername.delegate = self
		registerPassword.delegate = self


		loginView.addSubview(imageViewLogin)
		registerView.addSubview(imageViewRegister)

		loginView.addSubview(loginUsername)
		loginView.addSubview(loginPassword)
		loginView.addSubview(loginButton)
		registerView.addSubview(registerUsername)
		registerView.addSubview(registerPassword)
		registerView.addSubview(registerButton)






		imageViewRegister.translatesAutoresizingMaskIntoConstraints = false
		imageViewRegister.topAnchor.constraint(equalTo: registerView.topAnchor, constant: 20).isActive = true
		imageViewRegister.centerXAnchor.constraint(equalTo: registerView.centerXAnchor).isActive = true
		imageViewRegister.widthAnchor.constraint(equalTo: imageViewRegister.heightAnchor).isActive = true




		loginUsername.topAnchor.constraint(equalTo: imageViewLogin.bottomAnchor, constant: 10).isActive = true
		loginUsername.centerXAnchor.constraint(equalTo: loginView.centerXAnchor).isActive = true

		loginPassword.topAnchor.constraint(equalTo: loginUsername.bottomAnchor, constant: 20).isActive = true
		loginPassword.centerXAnchor.constraint(equalTo: loginView.centerXAnchor).isActive = true

		registerUsername.topAnchor.constraint(equalTo: imageViewRegister.bottomAnchor, constant: 10).isActive = true
		registerUsername.centerXAnchor.constraint(equalTo: registerView.centerXAnchor).isActive = true

		registerPassword.topAnchor.constraint(equalTo: registerUsername.bottomAnchor, constant: 20).isActive = true
		registerPassword.centerXAnchor.constraint(equalTo: registerView.centerXAnchor).isActive = true



		loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
		loginView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
		loginView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
		registerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
		registerView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
		registerView.leftAnchor.constraint(equalTo: loginView.rightAnchor).isActive = true

		loginSelected = loginView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9)
		registerSelected = loginView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.1)

		loginLabel.centerXAnchor.constraint(equalTo: loginView.centerXAnchor).isActive = true
		loginLabel.centerYAnchor.constraint(equalTo: loginView.centerYAnchor).isActive = true

		registerLabel.centerXAnchor.constraint(equalTo: registerView.centerXAnchor).isActive = true
		registerLabel.centerYAnchor.constraint(equalTo: registerView.centerYAnchor).isActive = true


		NSLayoutConstraint.activate([loginSelected])


		imageViewRegister.alpha = 0
		loginLabel.alpha = 0
		registerUsername.alpha = 0
		registerPassword.alpha = 0
		loginLabel.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
		registerLabel.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
		registerButton.alpha = 0
		registerButton.isEnabled = false

		imageViewLogin.translatesAutoresizingMaskIntoConstraints = false
		imageViewLogin.topAnchor.constraint(equalTo: loginView.topAnchor, constant: 20).isActive = true
		imageViewLogin.centerXAnchor.constraint(equalTo: loginView.centerXAnchor).isActive = true
		imageViewLogin.widthAnchor.constraint(equalTo: imageViewLogin.heightAnchor).isActive = true
		let imageSize = imageViewLogin.heightAnchor.constraint(equalToConstant: 150)
		imageSize.priority = 999

		NSLayoutConstraint.activate([imageSize])

		loginButton.setOptify()
		loginButton.topAnchor.constraint(equalTo: loginPassword.bottomAnchor, constant: 35).isActive = true
		loginButton.centerXAnchor.constraint(equalTo: loginView.centerXAnchor).isActive = true

		registerButton.setOptify()
		registerButton.topAnchor.constraint(equalTo: registerPassword.bottomAnchor, constant: 35).isActive = true
		registerButton.centerXAnchor.constraint(equalTo: registerView.centerXAnchor).isActive = true

		self.loginHorizontalConstraint =  loginButton.bottomAnchor.constraint(lessThanOrEqualTo: loginView.centerYAnchor)
		self.registerHorizontalConstraint =  registerButton.bottomAnchor.constraint(lessThanOrEqualTo: registerView.centerYAnchor)



	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		self.loginButton.addBorder(side: .Bottom, color: .white, width: 2.0)
		self.registerButton.addBorder(side: .Bottom, color: .white, width: 2.0)

	}


	func registerTapped() {
		if !registerSelected.isActive {
			switchItems()
		}
	}

	func loginTapped() {
		if !loginSelected.isActive {
			switchItems()
		}
	}

	func switchItems()  {

		if self.loginSelected.isActive {

			self.registerLabel.alpha = 0
		} else {
			self.loginLabel.alpha = 0
		}

		UIView.animate(withDuration: 0.5, animations: { _ in
			if self.loginSelected.isActive {
				NSLayoutConstraint.deactivate([self.loginSelected])
				NSLayoutConstraint.activate([self.registerSelected])

				self.imageViewLogin.alpha = 0
				self.imageViewRegister.alpha = 1
				self.loginUsername.alpha = 0
				self.loginPassword.alpha = 0
				self.registerUsername.alpha = 1
				self.registerPassword.alpha = 1
				self.loginButton.alpha = 0
				self.loginButton.isEnabled = false
				self.registerButton.alpha = 1
				self.registerButton.isEnabled = true

			} else {
				NSLayoutConstraint.deactivate([self.registerSelected])
				NSLayoutConstraint.activate([self.loginSelected])

				self.imageViewLogin.alpha = 1
				self.imageViewRegister.alpha = 0
				self.loginUsername.alpha = 1
				self.loginPassword.alpha = 1
				self.registerUsername.alpha = 0
				self.registerPassword.alpha = 0
				self.loginButton.alpha = 1
				self.loginButton.isEnabled = true
				self.loginLabel.alpha = 0
				self.registerButton.alpha = 0
				self.registerButton.isEnabled = false



			}
			self.view.layoutIfNeeded()
		}, completion: { status in
			if self.loginSelected.isActive {
				self.loginLabel.alpha = 0
				self.registerLabel.alpha = 1
			} else {
				self.loginLabel.alpha = 1
				self.registerLabel.alpha = 0
			}

		})




	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}

}

enum SKFTextField {
	case password
	case username

}

extension SkyFloatingLabelTextFieldWithIcon {
	func setOptify(type: SKFTextField) {
		switch type {
		case .password:
			iconText = "\u{f084}"
			placeholder = "PASSWORD"
			title = "PASSWORD"
			isSecureTextEntry = true
			break
		case .username:
			iconText = "\u{f007}"
			placeholder = "USERNAME"
			title = "USERNAME"
			break
		}


		iconFont = UIFont(name: "FontAwesome", size: 15)
		selectedIconColor = UIColor.white.withAlphaComponent(0.7)
		selectedTitleColor = UIColor.white.withAlphaComponent(0.7)
		textColor = .white
		selectedLineColor = .white
		translatesAutoresizingMaskIntoConstraints = false
		heightAnchor.constraint(equalToConstant: 50).isActive = true
		widthAnchor.constraint(equalToConstant: 150).isActive = true
	}
}

public enum UIButtonBorderSide {
	case Top, Bottom, Left, Right
}


extension UIButton {
	func setOptify() {
		translatesAutoresizingMaskIntoConstraints = false
		heightAnchor.constraint(equalToConstant: 28).isActive = true
		widthAnchor.constraint(equalToConstant: 150).isActive = true
		setTitle("LOGIN", for: .normal)
	}
}

extension UIButton {

	public func addBorder(side: UIButtonBorderSide, color: UIColor, width: CGFloat) {
		let border = CALayer()
		border.backgroundColor = color.cgColor

		switch side {
		case .Top:
			border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: width)
		case .Bottom:
			border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
		case .Left:
			border.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
		case .Right:
			border.frame = CGRect(x: self.frame.size.width - width, y: 0, width: width, height: self.frame.size.height)
		}

		self.layer.addSublayer(border)
	}
}

extension ViewController : UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		if textField == loginUsername {
			_ = loginPassword.becomeFirstResponder()
		} else if textField == loginPassword {
			_ = loginPassword.resignFirstResponder()
		} else if textField == registerPassword {
			_ = registerPassword.resignFirstResponder()
		} else if textField == registerUsername {
			_ = registerUsername.becomeFirstResponder()
		}





		return true
	}

}
