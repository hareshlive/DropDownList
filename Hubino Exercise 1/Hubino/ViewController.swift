//
//  ViewController.swift
//  Hubino
//
//  Created by wmdev-sep on 08/05/21.
//

import UIKit
import CoreData
import DropDown



class ViewController: UIViewController,UITextFieldDelegate {

    //MARK: Variable Decleration
    
    @IBOutlet weak var txtDropDown: UITextField!
    let viewModel = UserViewModel()
    var arrUserData = [Result]()
    var arrUserSavedData: [NSManagedObject] = []
    var isApiData = false
    let dropDown = DropDown()
    //MARK: Outlet Decleration
    @IBOutlet weak var tableViewUser: UITableView! {
        didSet {
            tableViewUser.dataSource = self
            tableViewUser.delegate = self
            tableViewUser.register(UINib.init(nibName: UserListCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: UserListCell.reuseIdentifier)
            tableViewUser.rowHeight = 100

        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let arrUser =  self.fetchUserData()
        if let arr = arrUser,arrUser?.count ?? 0 > 0 {
           // arrUserData = arr
            isApiData = false
            arrUserSavedData = arr
            self.tableViewUser.reloadData()
        }
        else{
            self.getUserData()
        }
    
        self.prepareViewModelObverser()
        txtDropDown.delegate = self
       

        // The view to which the drop down will appear on
        dropDown.anchorView = txtDropDown // UIView or UIBarButtonItem

        // The list of items to display. Can be changed dynamically
        dropDown.dataSource = ["Car", "Motorcycle", "Truck"]
       
        // Action triggered on selection
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            txtDropDown.text = item
        }
    }

}

//MARK: Custom Observer Methods
extension ViewController {
    func getUserData(){
        
        
        viewModel.fetchUserList()
    }
    
    func prepareViewModelObverser() {
        viewModel.getUserList = {[weak self] (finished) in
            self?.isApiData = true
            self?.arrUserData = self?.viewModel.userList ?? []
            self?.saveUserData(data: self?.viewModel.userList ?? [])
            self?.tableViewUser.reloadData()
        }
    }
    
}

//MARK: UI TextField Delegate
extension ViewController {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        dropDown.show()
        return false
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
       
    }
    
}

//MARK: UITableViewDelegate & DataSource Methods

extension ViewController:UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isApiData ? arrUserData.count : arrUserSavedData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserListCell.reuseIdentifier) as! UserListCell
        if isApiData {
            let result = arrUserData[indexPath.row]
            cell.setUserData(result: result)
        }
        else{
            let result = arrUserSavedData[indexPath.row]
            cell.lblFullName.text =  "\(result.value(forKey: "firstname") as? String ?? "") \(result.value(forKey: "lastname") as? String ?? "")"
            cell.lblEmail.text = result.value(forKey: "email") as? String ?? ""
            cell.lblMobileNo.text = result.value(forKey: "mobileno") as? String ?? ""
        }
        

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let resultDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "UserDetailViewController") as! UserDetailViewController
        if isApiData {
            let result = arrUserData[indexPath.row]
            resultDetailVC.resultData = result
            resultDetailVC.isApiData = isApiData
        }
        else {
            let result = arrUserSavedData[indexPath.row]
            resultDetailVC.result = result
        }
        
        self.navigationController?.pushViewController(resultDetailVC, animated: true)
    }
    
    
    

    
}


//MARK: UserDefault Local Storage

extension DefaultsKeys {
    var userResult: DefaultsKey<[Result]?> { .init("Result") }
}





//MARK: AppDelagate Obj

var appDelagateObject:AppDelegate {
    return UIApplication.shared.delegate as! AppDelegate
}

//MARK: CoreData Custom Methods
extension ViewController {
    
    func fetchUserData() -> [NSManagedObject]? {
      
        let managedContext =
          appDelagateObject.persistentContainer.viewContext
        
        //2
        let fetchRequest =
          NSFetchRequest<NSManagedObject>(entityName: "UserData")
        
        //3
        do {
            arrUserSavedData = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
        return arrUserSavedData
      }
    
    
    
    func saveUserData(data: [Result]) {
      let managedContext =
        appDelagateObject.persistentContainer.viewContext
    

      let entity =
        NSEntityDescription.entity(forEntityName: "UserData",
                                   in: managedContext)!
      
    
        for i in 0..<data.count {
            let userInfo = data[i]
            let userCore = NSManagedObject(entity: entity,
                                         insertInto: managedContext)
            userCore.setValue(userInfo.address, forKey: "address")
            userCore.setValue(userInfo.age, forKey: "age")
            userCore.setValue(userInfo.birthday, forKey: "birthday")
            userCore.setValue(userInfo.contactperson, forKey: "contactperson")
            userCore.setValue(userInfo.cpmobileno, forKey: "cpmobileno")
            userCore.setValue(userInfo.email, forKey: "email")
            userCore.setValue(userInfo.firstname, forKey: "firstname")
            userCore.setValue(userInfo.id, forKey: "id")
            userCore.setValue(userInfo.lastname, forKey: "lastname")
            userCore.setValue(userInfo.mobileno, forKey: "mobileno")
            
            // 4
            do {
              try managedContext.save()

            } catch let error as NSError {
              print("Could not save. \(error), \(error.userInfo)")
            }
            
            arrUserSavedData.append(userCore)
        }
      
      
      
      
    }

    
}



