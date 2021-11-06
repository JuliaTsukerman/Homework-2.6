//
//  ViewController.swift
//  HW 2
//
//  Created by Alexey Efimov on 12.06.2018.
//  Copyright © 2018 Alexey Efimov. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var colorView: UIView!

    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    var delegate: SettingsViewControllerDelegate?
    var sentColor: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorView.layer.cornerRadius = 15
        
        redSlider.minimumTrackTintColor = .red
        greenSlider.minimumTrackTintColor = .green
        
        colorView.backgroundColor = sentColor
        setSlidersValue()
        setValue(for: redLabel, greenLabel, blueLabel)
    }
    
    @IBAction func doneButtonPress() {
        let color = colorView.backgroundColor
        delegate!.setNewColor(for: color ?? .white)
        dismiss(animated:true)
    }
    
    @IBAction func rgbSlider(_ sender: UISlider) {
        
        switch sender {
        case redSlider:
            redLabel.text = string(from: redSlider)
        case greenSlider:
            greenLabel.text = string(from: greenSlider)
        default:
            blueLabel.text = string(from: blueSlider)
        }
        setColor()
    }
    

  private func setColor() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1)
    }
    
    
    private func setValue(for labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redLabel:
                redLabel.text = string(from: redSlider)
            case greenLabel:
                greenLabel.text = string(from: greenSlider)
            default:
                blueLabel.text = string(from: blueSlider)
            }
        }
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
}
extension SettingsViewController {
    private func setSlidersValue()  {
        var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alfa: CGFloat){
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alfa: CGFloat = 0
        sentColor.getRed(&red, green: &green, blue: &blue, alpha: &alfa)
            
        return (red, green, blue, alfa)
        }
        let redSliderValue = rgba.red
        redSlider.value = Float(redSliderValue)
        let greenSliderValue = rgba.green
        greenSlider.value = Float(greenSliderValue)
        let blueSliderValue = rgba.blue
        blueSlider.value = Float(blueSliderValue)
        }
}
