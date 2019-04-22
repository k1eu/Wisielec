//
//  ViewController.swift
//  Hangman
//
//  Created by Tomasz Kielar on 22/04/2019.
//  Copyright © 2019 Tomasz Kielar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var odpowiedzi : [String] = ["Gruszka","Rózia","Tattoo"]
    var szukanaOdpowiedz : String = ""
    @IBOutlet var litery: [UIButton]!
    
    func losowanie() {
        var random = Int.random(in: 0...odpowiedzi.count-1)
        szukanaOdpowiedz = odpowiedzi[random]
        print(szukanaOdpowiedz)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        losowanie()
    }

    @IBAction func literaPressed(_ sender: UIButton) {
        switch sender.currentTitle {
        default:
            print("Winter is coming")
        }
    }
    
}

