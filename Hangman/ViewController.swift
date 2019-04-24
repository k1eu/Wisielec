//
//  ViewController.swift
//  Hangman
//
//  Created by Tomasz Kielar on 22/04/2019.
//  Copyright © 2019 Tomasz Kielar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var ustawianie = SetUps()
    var rdzen = Core()
    
    var odpowiedzi : [String] = ["Gruszka","Rózia","Tattoo"]
    var szukanaOdpowiedz : String = ""
    var licznikBledow = 0
    var hangman:[UIImage] = [
        UIImage(named: "first")!,
        UIImage(named: "second")!,
        UIImage(named: "third")!,
        UIImage(named: "fourth")!,
        UIImage(named: "fifth")!,
        UIImage(named: "sixth")!,
        UIImage(named: "seventh")!,
        UIImage(named: "eighth")!,
        UIImage(named: "nineth")!
    ]
    var polskieZnaki = ["Ą","Ć","Ę","Ł","Ń","Ó","Ś","Ź","Ż"]
    var szukanaWZnakach : [String] = []
    var przegrana : Bool = false
    var stackView = UIStackView()
    @IBOutlet var litery: [UIButton]!
    
    func losowanie() {
        let random = Int.random(in: 0...odpowiedzi.count-1)
        szukanaOdpowiedz = odpowiedzi[random]
        print(szukanaOdpowiedz)
        let liczenie = szukanaOdpowiedz.count
        for every in 0...liczenie-1 {
            if every == 0 {
                let index = szukanaOdpowiedz.startIndex
                szukanaWZnakach.append(String(szukanaOdpowiedz.first!))
            }
            else {
            let indexZnaku = szukanaOdpowiedz.index(szukanaOdpowiedz.startIndex,offsetBy: every)
                szukanaWZnakach.append(String(szukanaOdpowiedz[indexZnaku])) }
        }
    }
    
    
    
    func guess(button:UIButton) {
        let xd = button.titleLabel!.text?.first?.lowercased()
        if szukanaOdpowiedz.lowercased().contains(xd!){
            print("zgadłeś")
            let lol = stackView.arrangedSubviews.count
            var array = [Int]()
            for index in 0..<lol {
                let pol = stackView.arrangedSubviews[index] as! UILabel
                if szukanaWZnakach[index].lowercased() == xd {
                    array.append(index)
                }
                else {continue}
            }
            for every in array {
                let stack = stackView.arrangedSubviews[every] as! UILabel
                stack.text = szukanaWZnakach[every]
            }
            let czy = rdzen.czyWygrałeś(stack: stackView,szukanaWZnakach:szukanaWZnakach)
            if czy{
                for every in litery {
                    every.isHidden = true
                }
            }
            
        }
        else {
            print("pudło")
            let hangObraz = hangman[licznikBledow]
            let viewObraz = UIImageView(image: hangObraz)
            view.addSubview(viewObraz)
            ustawianie.ustawianieObrazu(obraz: viewObraz,view:view)
            viewObraz.setImageColor(color: .white)
            licznikBledow += 1
            print(licznikBledow)
            if licznikBledow >= hangman.count {
                print("The End")
                for every in litery {
                    every.isEnabled = false
                    every.isHidden = true
                }
               }
        }
        
        
        
    }
    
    func slowoNaLitery (odpowiedz : String) {
        
        let liczbaLiter = odpowiedz.count
        for every in 1...liczbaLiter {
            let pole = UILabel()
            view.addSubview(pole)
            ustawianie.ustawLabele(label: pole, liczba: every, odpowiedz: odpowiedz)
            pole.text = "_"
            stackView.addArrangedSubview(pole)
        }
        view.addSubview(stackView)
        ustawianie.ustawStackView(stack: stackView,view : view)
        print(stackView.subviews)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        losowanie()
        ustawianie.ustawianieButtonow(button: litery,polskieZnaki:polskieZnaki)
        slowoNaLitery(odpowiedz: szukanaOdpowiedz)
        let pl = stackView.arrangedSubviews.count
    }
    

    @IBAction func literaPressed(_ sender: UIButton) {
        let dx : Bool = rdzen.czyWygrałeś(stack: stackView, szukanaWZnakach: szukanaWZnakach)
        guess(button: sender)
    }
}





extension UIImageView {
    func setImageColor(color: UIColor) {
        let tymczasowyObraz = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = tymczasowyObraz
        self.tintColor = color
    }
}
