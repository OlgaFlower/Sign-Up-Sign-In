//
//  LogedInPresenter.swift
//  Sign Up-Sign In
//
//  Created by Admin on 16.03.2020.
//  Copyright © 2020 Flower. All rights reserved.
//

import Foundation

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
    
//    func insertNewRow() {
//        guard let vc = loggedInVC else { return }
//        let indexPath = IndexPath(row: vc.userAddedTextField.count - 1, section: 1)
//        vc.tableView.beginUpdates()
//        vc.tableView.insertRows(at: [indexPath], with: .automatic)
//        vc.tableView.endUpdates()
//    }
    
    //count number of rows for each section
    func rowsNumberInTable(_ section: Int) -> Int {
        guard let data = recievedData else { return 0 }
        guard let vc = loggedInVC else { return 0 }
        var rowsNumber = 0
        
        if section == 0 {
            rowsNumber = data.count
        }
        if section == 1 {
//            guard let addedRows = vc.userAddedTextField.count else { return 0 }
            rowsNumber = vc.userAddedTextField.count
        }
        return rowsNumber
    }
}


