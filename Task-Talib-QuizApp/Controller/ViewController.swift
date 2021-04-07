//
//  ViewController.swift
//  Task-Talib-QuizApp
//
//  Created by Syed abu talib on 31/03/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func startQuiz(_ sender: Any) {
        let quizVC = storyboard?.instantiateViewController(identifier: "quizVC") as! QuizViewController
        quizVC.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(quizVC, animated:true)
      
    }
    @IBAction func resultQuiz(_ sender: Any) {
        let resultVC = storyboard?.instantiateViewController(identifier: "resultVC") as! ResultViewController
        resultVC.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(resultVC, animated: true)
    }
    
}

