//
//  ViewController.swift
//  PickinFruit
//
//  Created by Flatiron School on 7/17/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var spinButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var fruitPicker: UIPickerView!
    
    
    var fruitsArray = ["🍎", "🍊", "🍌", "🍐", "🍇", "🍉", "🍓", "🍒", "🍍"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.spinButton.accessibilityLabel = Constants.SPIN_BUTTON
        fruitPicker.delegate = self
    }
    
    @IBAction func spinButtonTapped(_ sender: UIButton) {
        
        for count in 0...fruitPicker.numberOfComponents - 1 {
            
            
            
            fruitPicker.selectRow( 3 , inComponent: count, animated: false)
            
        }
        
        for count in 0...fruitPicker.numberOfComponents - 1 {

            let itemIndex = Int(arc4random_uniform(UInt32(fruitsArray.count))) + fruitsArray.count * 8
            
            fruitPicker.selectRow(itemIndex, inComponent: count, animated: true)
            
        }
        
        if fruitPicker.selectedRow(inComponent: 0) == fruitPicker.selectedRow(inComponent: 1) &&
            fruitPicker.selectedRow(inComponent: 0) == fruitPicker.selectedRow(inComponent: 2) {
            resultLabelAnimate(text: "WINNER!")
        } else {
            resultLabelAnimate(text: "TRY AGAIN")
        }
    }

    func resultLabelAnimate(text: String) {
        resultLabel.text = text
        resultLabel.alpha = 0.0
        
        UIView.animateKeyframes(withDuration: 0.5, delay: 0.3, options: .calculationModeLinear, animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.05, animations: {
                self.resultLabel.alpha = 1.0
            })
            UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.15, animations: {
                self.resultLabel.alpha = 0.0
            })
            UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.15, animations: {
                self.resultLabel.alpha = 1.0
            })
            UIView.addKeyframe(withRelativeStartTime: 0.9, relativeDuration: 0.15, animations: {
                self.resultLabel.alpha = 0.0
            })
            
            })
    }
    
    
}

// MARK: UIPickerDelegate and DataSource
extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return fruitsArray.count * 10
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let title = fruitsArray[row % fruitsArray.count]
        return title
    }
    
    
    
}



// MARK: Set Up
extension ViewController {
    
    override func viewDidLayoutSubviews() {
        if self.spinButton.layer.cornerRadius == 0.0 {
            configureButton()
        }
    }
    
    func configureButton()
    {
        self.spinButton.layer.cornerRadius = 0.5 * self.spinButton.bounds.size.width
        self.spinButton.layer.borderColor = UIColor.white.cgColor
        self.spinButton.layer.borderWidth = 4.0
        self.spinButton.clipsToBounds = true
    }
    
}



