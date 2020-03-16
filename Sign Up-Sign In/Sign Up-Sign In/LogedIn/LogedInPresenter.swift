//
//  LogedInPresenter.swift
//  Sign Up-Sign In
//
//  Created by Admin on 16.03.2020.
//  Copyright © 2020 Flower. All rights reserved.
//

import Foundation

class LogedInPresenter {
    
    let dataService = DataService()
//    weak var loginVC: LogedInViewController?
//    var recievedData: DataModel?
    var recievedData: [String]?
    
    //MARK: - Load data
    func loadData(completion: @escaping ([String]?) -> Void) {
        dataService.fetchData { [weak self] data in
            self?.recievedData = data
            completion(data)
        }
    }
    
    
}


