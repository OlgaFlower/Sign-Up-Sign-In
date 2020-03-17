//
//  LogedInViewController.swift
//  Sign Up-Sign In
//
//  Created by Admin on 14.03.2020.
//  Copyright © 2020 Flower. All rights reserved.
//

import UIKit

class LogedInViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let authPresenter = AuthPresenter()
    let presenter = LogedInPresenter()
    let defaults = UserDefaults.standard
    var loggedInCondition: Bool?
    var userAddedRows: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.loggedInVC = self
        presenter.loadData { data in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        authPresenter.setNavBar(self)
        //create nav bar buttons
        let logoutButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutTapped))
        
        let addButton = UIButton()
        addButton.setImage(UIImage(named: "plus.png"), for: .normal)
        addButton.addTarget(self, action: #selector(addTapped), for: UIControl.Event.touchUpInside)
        let addRowButton = UIBarButtonItem(customView: addButton)
        navigationItem.rightBarButtonItems = [logoutButton, addRowButton]
    }
    
    @objc func logoutTapped() {
        //save condition to userDefaults
        defaults.set(false, forKey: "loggedInCondition")
        print("logoutTapped")
        //return to the previous VC
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func addTapped() {
        print("add button tapped")
        
        
    }
    
}

extension LogedInViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.rowsNumberInTable(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "logedInCell", for: indexPath) as! LogedInTableViewCell
        guard let data = presenter.recievedData else { return UITableViewCell() }
        cell.label.text = data[indexPath.row]
        return cell
    }
    
}
