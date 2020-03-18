//
//  LogedInViewController.swift
//  Sign Up-Sign In
//
//  Created by Admin on 14.03.2020.
//  Copyright © 2020 Flower. All rights reserved.
//

import UIKit

class LogedInViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let authPresenter = AuthPresenter()
    let presenter = LogedInPresenter()
    let defaults = UserDefaults.standard
    var loggedInCondition: Bool?
    
    var userAddedText = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
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
    
    //MARK: - add row to tableview
    @objc func addTapped() {
        userAddedText.append("")
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
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
        cell.selectionStyle = .none
        guard let data = presenter.recievedData else { return UITableViewCell() }
        
        switch indexPath.section {
        case 0:
            cell.label.text = data[indexPath.row]
            return cell
        case 1:
            cell.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
            cell.label.text = userAddedText[indexPath.row]
            return cell
        default:
            break
        }
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //MARK: - Edit row
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if indexPath.section == 1 {
        let edit = UIContextualAction(style: .normal, title: "Edit") { (contextualAction, view, actionPerformed: (Bool) -> Void) in
            
            self.presenter.editUserItem(indexPath)
            
        }
        
        edit.backgroundColor = #colorLiteral(red: 0.3606874657, green: 0.3401126865, blue: 0.009175551238, alpha: 1)
        edit.title = "Edit"
        
        return UISwipeActionsConfiguration(actions: [edit])
        }
        return nil
    }
    
    //MARK: - Remove row
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: "Delete") { (contextualAction, view, actionPerformed: (Bool) -> Void) in
            print("delete")
            self.presenter.recievedData?.remove(at: indexPath.row)
            DispatchQueue.main.async {
                self.tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
                tableView.reloadData()
            }
        }
        delete.backgroundColor = #colorLiteral(red: 0.8960420025, green: 0, blue: 0.08362072053, alpha: 1)
        delete.title = "Delete"
        return UISwipeActionsConfiguration(actions: [delete])
    }

}


