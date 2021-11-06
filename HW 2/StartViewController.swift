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

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else {return}
        settingsVC.sentColor = view.backgroundColor
        settingsVC.delegate = self
      
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
//MARK: - SettingsViewControllerDelegate
extension StartViewController:SettingsViewControllerDelegate {
    func setNewColor( for color: UIColor){
        view.backgroundColor = color
    }
}
    
    

