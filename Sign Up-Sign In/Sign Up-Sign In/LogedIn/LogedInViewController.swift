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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.loadData { data in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        authPresenter.setNavBar(self)
    }
}

extension LogedInViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = presenter.recievedData?.count else { return 0 }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "logedInCell", for: indexPath) as! LogedInTableViewCell
        guard let data = presenter.recievedData else { return UITableViewCell() }
        cell.label.text = data[indexPath.row]
        return cell
    }
    
}
