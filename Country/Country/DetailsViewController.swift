//
//  DetailsViewController.swift
//  Country
//
//  Created by Dharaneesh Venkatesh on 28/06/2025.
//

import UIKit

class DetailsViewController: UIViewController{
    
    

    @IBOutlet weak var detailsTableview: UITableView!
    
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        if let user = user {
            let label = UILabel()
            label.numberOfLines = 0
            label.frame = CGRect(x: 20, y: 100, width: view.frame.width - 40, height: 200)
            label.text = "Name: \(user.name)\nEmail: \(user.email)\nCity: \(user.address.city)"
            view.addSubview(label)
        }

        
    }
    
   
    

}
