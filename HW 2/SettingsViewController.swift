//
//  ViewController.swift
//  HW 2
//
//  Created by Alexey Efimov on 12.06.2018.
//  Copyright © 2018 Alexey Efimov. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
   
    //MARK: - IBOutlets
    @IBOutlet weak var colorView: UIView!

    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet var redSliderTF: UITextField!
    @IBOutlet var greenSliderTF: UITextField!
    @IBOutlet var blueSliderTF: UITextField!
    
    //MARK: - Public properties
    var delegate: SettingsViewControllerDelegate?
    var sentColor: UIColor!
    
    //MARK: - Navigation
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorView.layer.cornerRadius = 15
        
        redSlider.minimumTrackTintColor = .red
        greenSlider.minimumTrackTintColor = .green
        
        redSliderTF.delegate = self
        greenSliderTF.delegate = self
        blueSliderTF.delegate = self
        
        colorView.backgroundColor = sentColor
        
        setSlidersValue()
        setValue(for: redLabel, greenLabel, blueLabel)
        setValueForTF(for: redSliderTF,greenSliderTF, blueSliderTF)
        
        addDoneButtonTo(textField: redSliderTF)
        addDoneButtonTo(textField: greenSliderTF)
        addDoneButtonTo(textField: blueSliderTF)
                
    }
    
    //MARK: - IBAction functions
    @IBAction func doneButtonPress() {
        
        let color = colorView.backgroundColor
        delegate!.setNewColor(for: color ?? .white)
        dismiss(animated:true)
    }
    
    @IBAction func rgbSlider(_ sender: UISlider) {
        
        switch sender {
        case redSlider:
            redLabel.text = string(from: redSlider)
            redSliderTF.text = string(from: redSlider)
        case greenSlider:
            greenLabel.text = string(from: greenSlider)
            greenSliderTF.text = string(from: greenSlider)
        default:
            blueLabel.text = string(from: blueSlider)
            blueSliderTF.text = string(from: blueSlider)
        }
        setColor()
    }
    
    //MARK: - Private functions
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
    
    private func setValueForTF(for textfields: UITextField...){
        textfields.forEach { textfield in
        switch textfield {
        case redSliderTF:
            redSliderTF.text = string(from: redSlider)
       case greenSliderTF:
            greenSliderTF.text = string(from: greenSlider)
        default:
            blueSliderTF.text = string(from: blueSlider)
        }
      }
    }
   
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
}

//MARK: - Extensions

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
    
    private func showAlert(title: String, message: String, textField: UITextField? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            textField?.text = ""
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    private func addDoneButtonTo (textField:UITextField){
                let bar = UIToolbar()
                let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
                let done = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonTapped))
                bar.items = [flexibleSpace,done]
                bar.sizeToFit()
                textField.inputAccessoryView = bar
            }

             @objc private func doneButtonTapped() {
                 view.endEditing(true)
            }
        
    }


//MARK: - UITextFieldDelegate
extension SettingsViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let textValue = textField.text else {return}
        if let inputTextValue = Float(textValue){
            switch textField.tag {
            case 0: redSlider.value = inputTextValue
            case 1: greenSlider.value = inputTextValue
            case 2: blueSlider.value = inputTextValue
            default: break
            }
            setColor()
            setValue(for: redLabel, greenLabel, blueLabel)
            
        } else {
            showAlert(title: "Wrong format", message: "Please enter correct data")
        }
    }
}
