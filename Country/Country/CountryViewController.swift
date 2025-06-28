//
//  CountryViewController.swift
//  Country
//
//  Created by Dharaneesh Venkatesh on 26/06/2025.
//

import UIKit

class CountryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var countryListTableView: UITableView!
   
    var users: [User] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "PersonTableViewCell", bundle: nil)
        countryListTableView.register(nib, forCellReuseIdentifier: "PersonTableViewCell")
        countryListTableView.delegate = self
        countryListTableView.dataSource = self
        countryListTableView.rowHeight = UITableView.automaticDimension
        countryListTableView.estimatedRowHeight = 60
        countryListTableView.rowHeight = UITableView.automaticDimension
        countryListTableView.estimatedRowHeight = 200

        
        fetchUsers { users in
                DispatchQueue.main.async {
                    self.users = users
                    self.countryListTableView.reloadData()
                }
            }
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonTableViewCell",
                                                 for:indexPath) as! PersonTableViewCell
            let user = users[indexPath.row]
        
      
        cell.personName?.text = user.name
       
            cell.detailTextLabel?.text = "\(user.email) - \(user.address.city)"
            return cell
            }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Instantiate the new view controller
        let detailVC = DetailsViewController()

        // (Optional) Pass data to the next VC
        
        detailVC.user = users[indexPath.row]

        // Push it onto the navigation stack
        self.navigationController?.pushViewController(detailVC, animated: true)
    }



func fetchUsers(completion: @escaping ([User]) -> Void) {
    let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
    
    URLSession.shared.dataTask(with: url) { data, response, error in
        if let data = data {
            do {
                let users = try JSONDecoder().decode([User].self, from: data)
                completion(users)
            } catch {
                print("❌ Decoding error:", error)
            }
        } else if let error = error {
            print("❌ Network error:", error)
        }
    }.resume()
}

}
