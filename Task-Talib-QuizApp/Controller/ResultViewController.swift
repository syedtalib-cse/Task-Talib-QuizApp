//
//  ResultViewController.swift
//  Task-Talib-QuizApp
//
//  Created by Syed abu talib on 31/03/21.
//

import UIKit
import CoreData

class ResultViewController: UIViewController {
    var resultTV:UITableView!
    var storedData:[NSManagedObject] = []
    var currentMo:NSManagedObject!
    var moc:NSManagedObjectContext!
    var dateTimeArr:[String] = []
    var scoreArr:[Int] = []
    var ad:AppDelegate!
    override func viewDidLoad() {
        super.viewDidLoad()
        ad = UIApplication.shared.delegate as! AppDelegate
        moc = ad.persistentContainer.viewContext
        createTV()
        fetch()

        // Do any additional setup after loading the view.
    }
    //MARK:Fetching
    func fetch(){
        var fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName:"Result")
        do{
            storedData =  try moc.fetch(fetchReq) as [NSManagedObject]
            print(storedData.count)
            for i in 0..<storedData.count{
                 currentMo = storedData[i] as NSManagedObject
                dateTimeArr.append(currentMo.value(forKey:"dateTime")! as! String)
                scoreArr.append(currentMo.value(forKey:"score")! as! Int)
            }
            print("Fetch Data Sucessfully")
        }catch{
            print("Unable To fetch Data")
        }
        
    
    }
    //MARK: Create TableView
    func createTV(){
        resultTV = UITableView(frame:view.frame, style:.plain)
        resultTV.delegate = self
        resultTV.dataSource = self
        let nib = UINib(nibName:"ResultTableViewCell", bundle:nil)
        resultTV.register(nib, forCellReuseIdentifier:"resultTV")
        view.addSubview(resultTV)
        DispatchQueue.main.async {
            self.resultTV.reloadData()
        }
    }
     

}

//MARK: TableView Delegates
extension ResultViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storedData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"resultTV")
            as! ResultTableViewCell
        cell.lblScore.text = "\(scoreArr[indexPath.row])"
        cell.lblDateTime.text = dateTimeArr[indexPath.row]
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    
    
}
