//
//  ViewController.swift
//  Hangman
//
//  Created by Tomasz Kielar on 22/04/2019.
//  Copyright © 2019 Tomasz Kielar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //setup variables
    var ustawianie = SetUps()
    var rdzen = Core()
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
    var słownik : [String] = []
    var polskieZnaki = ["Ą","Ć","Ę","Ł","Ń","Ó","Ś","Ź","Ż"]
    var szukanaWZnakach : [String] = []
    var przegrana : Bool = false
    var stackView = UIStackView()
    let filePath = URL(fileURLWithPath: Bundle.main.path(forResource: "slownik", ofType: "txt")!)
    
    // end of setup variables
    @IBOutlet var litery: [UIButton]!
    
    func setSlownik() {
        var dataa : String = ""
        do {
        dataa = try String(contentsOf: filePath , encoding: .utf8)
        } catch let error as NSError {
            print("Failed reading from URL: \(filePath), Error: " + error.localizedDescription)
        }
        słownik = dataa.components(separatedBy: "\n")
        słownik = słownik.dropLast()
    }
    
    func losowanie() {
        let random = Int.random(in: 0...słownik.count-1)
        szukanaOdpowiedz = słownik[random]
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
    
    
    func guess(button:UIButton) {           //core function
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
                let youWon = UILabel()
                view.addSubview(youWon)
                ustawianie.ustawWin(label:youWon,view:view,tekscik:"Gratulacje, Wygrałeś")
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
                let liczba = stackView.arrangedSubviews.count
                
                for index in 0...liczba-1 {
                    let access = stackView.arrangedSubviews[index] as! UILabel
                    access.text = szukanaWZnakach[index]
                }
                let youLoose = UILabel()
                view.addSubview(youLoose)
                ustawianie.ustawWin(label:youLoose,view:view,tekscik:"Niestety, Przegrałeś!")
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
        setSlownik()
        losowanie()
        ustawianie.ustawianieButtonow(button: litery,polskieZnaki:polskieZnaki)
        slowoNaLitery(odpowiedz: szukanaOdpowiedz)
        
        print(słownik)
    }

    @IBAction func literaPressed(_ sender: UIButton) {
        let dx : Bool = rdzen.czyWygrałeś(stack: stackView, szukanaWZnakach: szukanaWZnakach)
        guess(button: sender)
        print(słownik)
    }
}


extension UIImageView {
    func setImageColor(color: UIColor) {
        let tymczasowyObraz = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = tymczasowyObraz
        self.tintColor = color
    }
}
