//
//  ViewController.swift
//  LoginScreen
//
//  Created by Tomas Sykora, jr. on 06/11/2016.
//  Copyright © 2016 AJTY, s.r.o. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	var loginSelected = NSLayoutConstraint()
	var registerSelected = NSLayoutConstraint()
	let loginView = UIView()
	let registerView = UIView()

	var labelCenterY = NSLayoutConstraint()
	var labelCenterX = NSLayoutConstraint()
	var closedLabel = NSLayoutConstraint()
	let label = UILabel()

	override func viewDidLoad() {
		super.viewDidLoad()

		loginView.translatesAutoresizingMaskIntoConstraints = false
		registerView.translatesAutoresizingMaskIntoConstraints = false
		label.translatesAutoresizingMaskIntoConstraints = false

		view.addSubview(loginView)
		view.addSubview(registerView)
		view.addSubview(label)


		label.text = "LOGIN"

		loginView.backgroundColor = .green
		registerView.backgroundColor = .gray

		let registerGesture = UITapGestureRecognizer(target: self, action:  #selector (self.registerTapped))
		self.registerView.addGestureRecognizer(registerGesture)
		let loginGesture = UITapGestureRecognizer(target: self, action:  #selector (self.loginTapped))
		self.loginView.addGestureRecognizer(loginGesture)

		let verticalConstraint = loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
		let leftConstraint = loginView.leftAnchor.constraint(equalTo: view.leftAnchor)
		let heightConstraint = loginView.heightAnchor.constraint(equalTo: view.heightAnchor)
		let rightRegister = registerView.rightAnchor.constraint(equalTo: view.rightAnchor)
		let heightRegister = registerView.heightAnchor.constraint(equalTo: view.heightAnchor)
		let leftRegister = registerView.leftAnchor.constraint(equalTo: loginView.rightAnchor)

		labelCenterX = label.centerXAnchor.constraint(equalTo: loginView.centerXAnchor)
		labelCenterY = label.centerYAnchor.constraint(equalTo: loginView.centerYAnchor)
		closedLabel = label.rightAnchor.constraint(equalTo: loginView.rightAnchor)


		registerSelected = self.loginView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.1)
		loginSelected = loginView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9)


		NSLayoutConstraint.activate([verticalConstraint, leftConstraint, heightConstraint, loginSelected,
		                             rightRegister, heightRegister, leftRegister,
									labelCenterY, labelCenterX])



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
		UIView.animate(withDuration: 0.75, animations: { _ in
			if self.loginSelected.isActive {
				NSLayoutConstraint.deactivate([self.loginSelected, self.labelCenterX])
				NSLayoutConstraint.activate([self.registerSelected, self.closedLabel])
				self.label.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
			} else {
				NSLayoutConstraint.deactivate([self.registerSelected, self.closedLabel])
				NSLayoutConstraint.activate([self.loginSelected,self.labelCenterX])
				self.label.transform = CGAffineTransform(rotationAngle: -CGFloat.pi * 2)

			}
			self.view.layoutIfNeeded()
		}, completion: nil)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

