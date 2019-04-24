//
//  setups.swift
//  Hangman
//
//  Created by Tomasz Kielar on 25/04/2019.
//  Copyright © 2019 Tomasz Kielar. All rights reserved.
//

import UIKit

class SetUps {
    
    func ustawianieButtonow (button:[UIButton], polskieZnaki : [String]) {
        for every in button {
            if polskieZnaki.contains(every.titleLabel!.text!) {
                every.titleLabel!.font = every.titleLabel!.font.withSize(20)
                every.setTitleColor(UIColor(red: 255, green: 182, blue: 193, alpha: 1), for: .normal)
                
            }
            else {
                every.titleLabel!.font = every.titleLabel!.font.withSize(20)
                every.setTitleColor(.white, for: .normal)
                every.setTitleShadowColor(UIColor(red: 255, green: 255, blue: 255, alpha: 0.5), for: .normal)
            }
        }
        
    }
    
    
    func ustawianieObrazu(obraz : UIImageView, view: UIView) {
        obraz.translatesAutoresizingMaskIntoConstraints = false
        obraz.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20).isActive = true
        obraz.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        obraz.widthAnchor.constraint(equalToConstant: view.bounds.width/1).isActive = true
        obraz.heightAnchor.constraint(equalTo: obraz.widthAnchor).isActive = true
    }
    
    func ustawLabele(label: UILabel,liczba : Int, odpowiedz : String) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red
        label.textAlignment = .center
        label.widthAnchor.constraint(equalToConstant: 40).isActive = true
        label.heightAnchor.constraint(equalToConstant: 40).isActive = true
        label.font = label.font.withSize(40)
        
    }
    func ustawStackView (stack:UIStackView, view:UIView) {
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        stack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
    }
}
