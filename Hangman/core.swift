//
//  core.swift
//  Hangman
//
//  Created by Tomasz Kielar on 25/04/2019.
//  Copyright © 2019 Tomasz Kielar. All rights reserved.
//

import UIKit

class Core {
    func czyPrzegrałeś(tablica:[UIImage],licznikBledow : Int) -> Bool {
        if licznikBledow >= tablica.count-1 {
            return true
        }
        else {
            return false
        }
        
    }
    
    
    func czyWygrałeś(stack:UIStackView, szukanaWZnakach : [String])->Bool {
        let wielkoscStacka = stack.arrangedSubviews.count
        var placeholder : Int = 0
        for every in 0...wielkoscStacka-1 {
            let stacker = stack.arrangedSubviews[every] as! UILabel
            if stacker.text == szukanaWZnakach[every] {
                placeholder += 1
                print("yes")
            }
            else {
                print("no")
            }
        }
        if placeholder == wielkoscStacka {
            print("YOU WON111111!!!")
            return true
            
        }
        else {
            print("still not win")
            return false
        }
        
    }
}
