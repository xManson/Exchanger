//
//  ViewController.swift
//  Exchanger
//

import UIKit

final class ViewController: BaseViewController {

    private let exchanger = Exchange()
    
    @IBOutlet weak var fromTextField: UITextField!
    @IBOutlet weak var resultLabewl: UILabel!
    
    @IBOutlet weak var fromPicker: UIPickerView!
    @IBOutlet weak var toPicker: UIPickerView!
    @IBOutlet weak var convertButton: UIButton!
    lazy var tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))

    override func viewDidLoad() {
        super.viewDidLoad()
        fromTextField.delegate = self
        fromPicker.delegate = self
        fromPicker.dataSource = self
        
        toPicker.delegate = self
        toPicker.dataSource = self
        
        let model = exchanger.model
        fromPicker.selectRow(model.from.intVal, inComponent: 0, animated: false)
        toPicker.selectRow(model.to.intVal, inComponent: 0, animated: false)
        
        convertButton.isEnabled = false
        resultLabewl.text = ""
        view.addGestureRecognizer(tap)
    }

    @objc
    private func handleTap(sender: UITapGestureRecognizer) {
        guard sender.state == .ended else {
            return
        }
        fromTextField.resignFirstResponder()
    }
    private func checkEnabledToChange() {
        let model = exchanger.model
        guard model.from != model.to else {
            convertButton.isEnabled = false
            return
        }
        convertButton.isEnabled = true
    }
    
    @IBAction func exchange(_ sender: Any) {
        Task {
            do {
                hudShow()
                let resust = try await exchanger.perform()
                resultLabewl.text = resust.result
                hudDismiss()
            } catch {
                hudDismiss()
                if let tError = error as? TError {
                    show(error: tError)
                } else {
                    show(text: error.localizedDescription)
                }
            }
        }    }
   
}

extension ViewController: UITextFieldDelegate {
    

    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        guard let text = textField.text, let sRange = text.range(from: range) else {
            return false
        }
        let modified = text.replacingCharacters(in: sRange, with: string)
        if let amount = Double(modified) , amount > 0 {
            if textField == fromTextField {
                
            }
            exchanger.model.amount = amount
            checkEnabledToChange()
            return true
        }
        exchanger.model.amount = 0
        checkEnabledToChange()
        return false
    }

    
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        Currency.allCases[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        Currency.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == fromPicker {
            exchanger.model.from = Currency.allCases[row]
        } else {
            exchanger.model.to = Currency.allCases[row]
        }
        checkEnabledToChange()
    }
    
    
    
}

