//
//  ViewController.swift
//  MortgageCalculator
//
//  Created by Thomas Morel on 5/29/19.
//  Copyright © 2019 Thomas Morel. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var interestSlider: UISlider!
    @IBOutlet weak var interestSliderValueLabel: UILabel!

    @IBOutlet weak var yearsSlider: UISlider!
    @IBOutlet weak var yearsSliderValueLabel: UILabel!

    @IBOutlet weak var loanAmountSlider: UISlider!
    @IBOutlet weak var loanAmountInputField: UITextField!

    @IBOutlet weak var monthlyPaymentLabel: UILabel!

    @IBAction func interestSliderValueChanged(_ sender: UISlider) {

        let step: Float = 0.25

        let roundedValue = round(sender.value / step) * step
        sender.value = roundedValue
        // Do something else with the value
        interestSliderValueLabel.text = String(format: "%.2f", sender.value)
        calculateMonthlyPayment()
   }

    @IBAction func yearsSliderValueChanged(_ sender: UISlider) {
        let roundedValue = round(sender.value)
        sender.value = roundedValue
        // Do something else with the value
        yearsSliderValueLabel.text = String(format: "%.0f", sender.value)
        calculateMonthlyPayment()
   }
    @IBAction func loanAmountSliderValueChanged(_ sender: UISlider) {
        let step: Float = 1000.0

        let roundedValue = round(sender.value / step) * step
        sender.value = roundedValue
        // Do something else with the value
        loanAmountInputField.text = String(format: "%.0f", sender.value)
        calculateMonthlyPayment()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)

        return false
    }

   @IBAction func textFieldDidEndEditing(_ textField: UITextField) {
    let loanAmount = Double(loanAmountInputField.text!) ?? 0.0
    loanAmountSlider.value = Float(Double(loanAmount))
        calculateMonthlyPayment()
    }


    private func calculateMonthlyPayment(){

        let monthlyInterestRate = Double( (interestSlider.value / 100.0) / 12)
        print(monthlyInterestRate)
        let numberOfMonthlyPayments = Int(yearsSlider.value * 12)
        print(numberOfMonthlyPayments)
        let tempPower = pow( (Double(1.0 + monthlyInterestRate)), Double(numberOfMonthlyPayments * -1))
        print(tempPower)
        let nextStepValue = Double(1 - tempPower)
        let interimValue = ( monthlyInterestRate / ( nextStepValue ) ) * Double(loanAmountSlider.value)


        monthlyPaymentLabel.text = String(format: "%.2f", interimValue )


    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        self.loanAmountInputField.delegate = self

        interestSliderValueLabel.text = String(format: "%.2f", interestSlider.value)
        yearsSliderValueLabel.text = String(format: "%.0f", yearsSlider.value)
        loanAmountInputField.text = String(format: "%.0f", loanAmountSlider.value)

         calculateMonthlyPayment()
    }


}

