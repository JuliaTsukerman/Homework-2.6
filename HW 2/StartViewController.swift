//
//  StartViewController.swift
//  HW 2
//
//  Created by Test on 11/5/21.
//  Copyright © 2021 Alexey Efimov. All rights reserved.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func setNewColor (for  color: UIColor)
}
class StartViewController: UIViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else {return}
        settingsVC.sentColor = view.backgroundColor
        settingsVC.delegate = self
    }
}
//MARK: - SettingsViewControllerDelegate
extension StartViewController:SettingsViewControllerDelegate {
    func setNewColor( for color: UIColor){
        view.backgroundColor = color
    }
}
    
    

