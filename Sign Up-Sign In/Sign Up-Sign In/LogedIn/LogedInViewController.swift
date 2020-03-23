//
//  LogedInViewController.swift
//  Sign Up-Sign In
//
//  Created by Admin on 14.03.2020.
//  Copyright © 2020 Flower. All rights reserved.
//

import UIKit
import MobileCoreServices //for drag-and-drop

class LogedInViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var logout: UIBarButtonItem!
    @IBOutlet weak var editTable: UIBarButtonItem!
    @IBOutlet weak var addRow: UIBarButtonItem!
    
    let authPresenter = AuthPresenter()
    let presenter = LogedInPresenter()
    let defaults = UserDefaults.standard
    
    var userAddedText = [String?]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.dragDelegate = self
        tableView.dropDelegate = self
        tableView.dragInteractionEnabled = true
        
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
        logout.title = "       Logout"
        editTable.title = "       Edit"
        addRow.image = UIImage(named: "plus.png")
        navigationItem.title = .none
    }
    
    //MARK: - Logout
    @IBAction func logoutButton(_ sender: Any) {
        //save condition to userDefaults
        defaults.set(false, forKey: "loggedInCondition")
        //return to the previous VC
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Edit table (drag-and-drop)
    @IBAction func dragAndDropButton(_ sender: UIBarButtonItem) {
        //switcher - change true to false, false to true
        tableView.isEditing.toggle()
        
        //disable addRow button while table is editing
        if tableView.isEditing {
            addRow.isEnabled = false
        } else {
            addRow.isEnabled = true
        }
        
        //if title == "Edit" rename it to "Done" and opposite
        sender.title = sender.title == "       Edit" ? "     Done" : "       Edit"
    }
    
    //MARK: - Add row to tableview
    @IBAction func addRowButton(_ sender: Any) {
        userAddedText.append("")
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension LogedInViewController: UITableViewDragDelegate, UITableViewDropDelegate {
    
    //MARK: - Disable delete buttons in edit mode
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    //MARK: - Moving cells
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //Handling drag-and-drop between sections
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        //move items from one section to another
        if sourceIndexPath.section != destinationIndexPath.section {
            if sourceIndexPath.section == 0 {
                let movedItem = self.presenter.recievedData![sourceIndexPath.row]
                self.presenter.recievedData!.remove(at: sourceIndexPath.row)
                self.userAddedText.insert(movedItem, at: destinationIndexPath.row)
            }
            if sourceIndexPath.section == 1 {
                let movedItem = self.userAddedText[sourceIndexPath.row]
                self.userAddedText.remove(at: sourceIndexPath.row)
                self.presenter.recievedData!.insert(movedItem!, at: destinationIndexPath.row)
            }
        }
    }
    
    //Drag
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        
        let string = indexPath.section == 0 ? presenter.recievedData?[indexPath.row] : userAddedText[indexPath.row]
        
        guard let data = string?.data(using: .utf8) else { return [] }
        
        let itemProvider = NSItemProvider(item: data as NSData, typeIdentifier: kUTTypePlainText as String)
        
        return [UIDragItem(itemProvider: itemProvider)]
    }
    
    //Drop
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        let destinationIndexPath: IndexPath
        
        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        } else {
            let section = tableView.numberOfSections - 1
            let row = tableView.numberOfRows(inSection: section)
            destinationIndexPath = IndexPath(row: row, section: section)
        }
        
        // load strings from the drop coordinator
        coordinator.session.loadObjects(ofClass: NSString.self) { items in
            // convert the item provider array to a string array
            guard let strings = items as? [String] else { return }
            
            // create an empty array to track rows we've copied
            var indexPaths = [IndexPath]()
            
            // loop over all the strings we received
            for (index, string) in strings.enumerated() {
                // create an index path for this new row, moving it down depending on how many we've already inserted
                let indexPath = IndexPath(row: destinationIndexPath.row + index, section: destinationIndexPath.section)
                
                if indexPath.section == 0 {
                    self.presenter.recievedData?.insert(string, at: indexPath.row)
                } else {
                    self.userAddedText.insert(string, at: indexPath.row)
                }
                // keep track of this new row
                indexPaths.append(indexPath)
            }
            // insert them all into the table view at once
            tableView.insertRows(at: indexPaths, with: .automatic)
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
            if indexPath.section == 0 {
                self.presenter.recievedData?.remove(at: indexPath.row)
            }
            if indexPath.section == 1 {
                self.userAddedText.remove(at: indexPath.row)
            }
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


