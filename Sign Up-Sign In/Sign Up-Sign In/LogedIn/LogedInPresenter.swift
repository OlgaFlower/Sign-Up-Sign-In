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
    
    //MARK: - Number of rows for each section
    func rowsNumberInTable(_ section: Int) -> Int {
        guard let data = recievedData else { return 0 }
        guard let vc = loggedInVC else { return 0 }
        
        if section == 0 {
            return data.count
        }
        if section == 1 {
                return vc.userAddedText.count
        }
        return 0
    }
    
    //MARK: - Interface for editing user's item
    func showAlertWithTextField(completion: @escaping (String)->Void) {
        guard let vc = loggedInVC else { return }
        
        let alertController = UIAlertController(title: "Edit item", message: nil, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Done", style: .default) { text in
            if let txtField = alertController.textFields?.first, let text = txtField.text {
                completion(text)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        alertController.addTextField { (textField) in
            textField.placeholder = "Edit..."
        }
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        vc.present(alertController, animated: true, completion: nil)
    }
    
    //MARK: - Add edited item to the user arr and reload table
    func editUserItem(_ index: IndexPath) {
        guard let vc = loggedInVC else { return }
        
        self.showAlertWithTextField { text in
            vc.userAddedText[index.row] = text
            DispatchQueue.main.async {
                vc.tableView.reloadData()
            }
            print(vc.userAddedText)
        }
    }
    
    
    
    
//    func dataToDisplay() -> [[String]?] {
//        guard let vc = loggedInVC else { return [[String]?]() }
//        return [recievedData, vc.userAddedText]
//        
//    }
//    
    
}


