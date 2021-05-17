//
//  UserDetailViewController.swift
//  Hubino
//
//  Created by wmdev-sep on 08/05/21.
//

import UIKit
import CoreData

class UserDetailViewController: UIViewController {
    @IBOutlet weak var lblFirstName: UILabel!
    @IBOutlet weak var lblLastName: UILabel!
    @IBOutlet weak var lblAge: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblMobileNo: UILabel!
    @IBOutlet weak var lblContactPerson: UILabel!
    @IBOutlet weak var lblContacePersonMNo: UILabel!
    var resultData:Result?
    var result:NSManagedObject?
    var isApiData = false
    override func viewDidLoad() {
        super.viewDidLoad()
        if isApiData {
            if let result = resultData {
                lblFirstName.text = "First Name : \(result.firstname ?? "")"
                lblLastName.text = "Last Name : \(result.lastname ?? "")"
                lblAge.text = "Age : \(result.age ?? "")"
                lblEmail.text = "Email Address : \(result.email ?? "")"
                lblMobileNo.text = "Mobile No : \(result.mobileno ?? "")"
                lblContactPerson.text = "Contact Person : \(result.contactperson ?? "")"
                lblContacePersonMNo.text = "Contact Person Contact No : \(result.cpmobileno ?? "")"
            }
        }
        else {
            if let data = result {
                lblFirstName.text = "First Name : \(data.value(forKey: "firstname") as? String ?? "")"
                lblLastName.text = "Last Name : \(data.value(forKey: "lastname") as? String ?? "")"
                lblAge.text = "Age : \(data.value(forKey: "age") as? String ?? "")"
                lblEmail.text = "Email Address : \(data.value(forKey: "email") as? String ?? "")"
                lblMobileNo.text = "Mobile No : \(data.value(forKey: "mobileno") as? String ?? "")"
                lblContactPerson.text = "Contact Person : \(data.value(forKey: "contactperson") as? String ?? "")"
                lblContacePersonMNo.text = "Contact Person Contact No : \(data.value(forKey: "cpmobileno") as? String ?? "")"
            }
        }
            
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "User Details"
    }
}



