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
    @IBOutlet var litery: [UIButton]!
    
    func losowanie() {
        let random = Int.random(in: 0...odpowiedzi.count-1)
        szukanaOdpowiedz = odpowiedzi[random]
        print(szukanaOdpowiedz)
    }
    
    func ustawianieButtonow (button:[UIButton]) {
        for every in button {
            every.titleLabel!.font.withSize(20)
            every.setTitleColor(.white, for: .normal)
            every.setTitleShadowColor(UIColor(red: 255, green: 255, blue: 255, alpha: 0.5), for: .normal)
        }
    }
    
    func guess(button:UIButton) {
        let xd = button.titleLabel!.text?.first?.lowercased()
        if szukanaOdpowiedz.lowercased().contains(xd!){
            print("zgadłeś")
        }
        else {
            print("pudło")
            let hangObraz = hangman[licznikBledow]
            let viewObraz = UIImageView(image: hangObraz)
            view.addSubview(viewObraz)
            ustawianieObrazu(obraz: viewObraz)
            viewObraz.setImageColor(color: .white)
            licznikBledow += 1
        }
        
        
        
    }
    func slowoNaLitery (odpowiedz : String) {
        let stackView = UIStackView()
        
        let liczbaLiter = odpowiedz.count
    for every in 1...liczbaLiter {
            let pole = UILabel()
        
        
        
            view.addSubview(pole)
        ustawLabele(label: pole, liczba: every, odpowiedz: odpowiedz)
            stackView.addArrangedSubview(pole)
        }
        view.addSubview(stackView)
        ustawStackView(stack: stackView)
        print(stackView.subviews)
    }
    func ustawLabele(label: UILabel,liczba : Int, odpowiedz : String) {
        label.translatesAutoresizingMaskIntoConstraints = false
        let indexZnaku = odpowiedz.index(odpowiedz.startIndex,offsetBy: liczba-1)
        label.text = String(odpowiedz[indexZnaku])
        label.textColor = .red
        label.textAlignment = .center
     //   label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
   //     label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: CGFloat(100*liczba)).isActive = true
        label.widthAnchor.constraint(equalToConstant: 40).isActive = true
        label.heightAnchor.constraint(equalToConstant: 40).isActive = true
        label.font = label.font.withSize(40)
        
    }
    func ustawStackView (stack:UIStackView) {
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        stack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true


    }
    func czyPrzegrałeś(tablica:[UIImage],licznikBledow : Int) -> Bool {
        if licznikBledow >= tablica.count-1 {
            return true
        }
        else {
            return false
        }
        
    }
    func ustawianieObrazu(obraz : UIImageView) {
        obraz.translatesAutoresizingMaskIntoConstraints = false
        obraz.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20).isActive = true
        obraz.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        obraz.widthAnchor.constraint(equalToConstant: view.bounds.width/1).isActive = true
        obraz.heightAnchor.constraint(equalTo: obraz.widthAnchor).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        losowanie()
        ustawianieButtonow(button: litery)
        slowoNaLitery(odpowiedz: szukanaOdpowiedz)
    }

    @IBAction func literaPressed(_ sender: UIButton) {
        let xd : Bool = czyPrzegrałeś(tablica: hangman, licznikBledow: licznikBledow)
        switch xd {
        case true:
            print("The End")
            for every in litery {
                every.isEnabled = false
                every.isHidden = true
            }
            let ostatniaCzesc = hangman[licznikBledow]
            let viewOstatni = UIImageView(image: ostatniaCzesc)
            view.addSubview(viewOstatni)
            ustawianieObrazu(obraz: viewOstatni)
            viewOstatni.setImageColor(color: .white)
        
        case false:
            guess(button: sender)
        }
        
    }
    
}

extension UIImageView {
    func setImageColor(color: UIColor) {
        let tymczasowyObraz = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = tymczasowyObraz
        self.tintColor = color
    }
}
