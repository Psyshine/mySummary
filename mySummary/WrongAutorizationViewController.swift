//
//  WrongAutorizationViewController.swift
//  mySummary
//
//  Created by Андрей Прокопенко on 4/26/19.
//  Copyright © 2019 Andry Pro. All rights reserved.
//

import UIKit

class WrongAutorizationViewController: UIViewController {

    var labelText = ""
    @IBOutlet weak var informationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        informationLabel.text = labelText
    }
    

    

}
