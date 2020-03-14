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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        authPresenter.setNavBar(self)
    }

}

extension LogedInViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "logedInCell", for: indexPath)
        
        return cell
    }
    
    
    
    
}
