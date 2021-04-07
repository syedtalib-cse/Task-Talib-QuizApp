//
//  QuizViewController.swift
//  Task-Talib-QuizApp
//
//  Created by Syed abu talib on 31/03/21.
//

import UIKit
import CoreData

class QuizViewController:UIViewController{
    var data:[Questions]!
    var questionsArr:[String] = []
    var questionNo:Int = 0
    @objc var score:Int = 0
    var answerArr:[AnswerDetails] = []
    var answerDetailsArr:[Answer] = []
    var ad:AppDelegate!
    var moc:NSManagedObjectContext!
    var resultEntityRef:NSEntityDescription!
    var alphabetArr:[String] = ["a","b","c"]
    var dateTimeString:String = ""
    @IBOutlet weak var lblQuestion: UILabel!
    @IBOutlet weak var lblOpt1: UILabel!
    @IBOutlet weak var lblOpt2: UILabel!
    @IBOutlet weak var lblOpt3: UILabel!
    @IBOutlet weak var btnOpt1: UIButton!
    @IBOutlet weak var btnOpt2: UIButton!
    @IBOutlet weak var btnOpt3: UIButton!
    @IBOutlet weak var btnPrev: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnSubmit: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        btnSubmit.isHidden = true
        parseJson()
        if(questionNo <= 0){
            btnPrev.isHidden = true
        }
     
        navigationItem.hidesBackButton = true
        answerDetails()
        updateUI()
        btnOpt1.addTarget(self, action:#selector((score(selectedBtn:))), for:.touchUpInside)
        btnOpt2.addTarget(self, action:#selector((score(selectedBtn:))), for:.touchUpInside)
        btnOpt3.addTarget(self, action:#selector((score(selectedBtn:))), for:.touchUpInside)
        dateformatter()
        ad = UIApplication.shared.delegate as! AppDelegate
        moc = ad.persistentContainer.viewContext
        resultEntityRef = NSEntityDescription.entity(forEntityName:"Result", in: moc)
      
        }
    func parseJson(){

        var url = Bundle.main.url(forResource:"Question", withExtension:"json")
        do {
            
            let jsonData = try Data(contentsOf:url!)
            let jsonObj = JSONDecoder()
             data = try jsonObj.decode([Questions].self, from:jsonData)
            for i in 0..<data.count{
                questionsArr.append(data[i].question!)
                answerDetailsArr.append(data[i].answers!)
                
            }
           
           

        } catch  {
            print("Something Went Wrong")
        }
    }
    @IBAction func prevQ(_ sender: Any) {
        questionNo -= 1
        updateUI()
    }
    
    @IBAction func nxtQ(_ sender: Any) {
        questionNo += 1
        btnPrev.isHidden = false
        updateUI()
        if(questionsArr.count-1 == questionNo){
            btnSubmit.isHidden = false
            btnNext.isHidden = true
            btnPrev.isHidden = true
            
        }
    }
    func updateUI(){
        lblQuestion.text = questionsArr[questionNo]
        lblOpt1.text = answerArr[questionNo].a
        lblOpt2.text = answerArr[questionNo].b
        lblOpt3.text = answerArr[questionNo].c
    }
    func answerDetails(){
        for i in 0..<answerDetailsArr.count{
            var answer = AnswerDetails(a:data[i].answers.map{$0.a!} as! String, b: data[i].answers.map{$0.b!} as! String, c: data[i].answers.map{$0.c!} as! String, correct: data[i].answers.map{$0.correct!} as! String)
            answerArr.append(answer)
            print(answerArr)
    }
    }
    @objc func score(selectedBtn:UIButton)
    {
        if(alphabetArr[selectedBtn.tag] == answerArr[questionNo].correct){
            score += 5
        }
        else{
            score -= 2
        }
        print("The Score print",score)
    }
    func dateformatter(){
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .long
        dateTimeString = formatter.string(from:currentDateTime)
        print("The Date Time String",dateTimeString)
    }
    func save(){
        //calling Managed Objects
       var resultMO = NSManagedObject(entity:resultEntityRef, insertInto: moc)
        resultMO.setValue(score, forKey:"score")
        resultMO.setValue(dateTimeString, forKey:"dateTime")
       do {
           try moc.save()
           print("Saving Using CoreData")
       } catch  {
           print("Error in Saving Using CoreData")
       }
        print("The Score Data",resultMO)
    }
    @IBAction func btnSubmit(_ sender: Any) {
       save()
        navigationController?.popToRootViewController(animated:true)
       
    }
  

}

