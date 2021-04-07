//
//  ResultTableViewCell.swift
//  Task-Talib-QuizApp
//
//  Created by Syed abu talib on 02/04/21.
//

import UIKit

class ResultTableViewCell: UITableViewCell {

    @IBOutlet weak var lblScore: UILabel!
    
    @IBOutlet weak var lblDateTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
