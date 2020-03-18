//
//  LogedInPresenter.swift
//  Sign Up-Sign In
//
//  Created by Admin on 16.03.2020.
//  Copyright © 2020 Flower. All rights reserved.
//

import UIKit

class LogedInPresenter {
    weak var loggedInVC: LogedInViewController?
    let dataService = DataService()
    var recievedData: [String]?
    
    //MARK: - Load data
    func loadData(completion: @escaping ([String]?) -> Void) {
        dataService.fetchData { [weak self] data in
            self?.recievedData = data
            completion(data)
        }
    }
    
    //count number of rows for each section
    func rowsNumberInTable(_ section: Int) -> Int {
        guard let data = recievedData else { return 0 }
        guard let vc = loggedInVC else { return 0 }
        var rowsNumber = 0
        
        if section == 0 {
            rowsNumber = data.count
        }
        if section == 1 {
            rowsNumber = vc.userAddedText.count ?? 0
        }
        return rowsNumber
    }
    
    //add new item by user
    func showAlertWithTextField(completion: @escaping (String)->Void) {
        guard let vc = loggedInVC else { return }
        
        let alertController = UIAlertController(title: "Add new item", message: nil, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Done", style: .default) { text in
            if let txtField = alertController.textFields?.first, let text = txtField.text {
                print("Text==>" + text)
                completion(text)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        alertController.addTextField { (textField) in
            textField.placeholder = "Tag"
        }
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        vc.present(alertController, animated: true, completion: nil)
    }
    
    func editUserItem(_ index: IndexPath) {
        guard let vc = loggedInVC else { return }
        
        self.showAlertWithTextField { text in
//            vc.userAddedText.append(text)
            vc.userAddedText[index.row] = text
            DispatchQueue.main.async {
                vc.tableView.reloadData()
            }
            print(vc.userAddedText)
        }
    }
    
}


