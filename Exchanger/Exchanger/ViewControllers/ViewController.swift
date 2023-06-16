//
//  ViewController.swift
//  Exchanger
//

import UIKit

final class ViewController: BaseViewController {

    private let exchanger = Exchange()
    
    @IBOutlet weak var fromTextField: UITextField!
    @IBOutlet weak var toTextField: UITextField!
    @IBOutlet weak var resultLabewl: UILabel!
    
    @IBOutlet weak var fromPicker: UIPickerView!
    @IBOutlet weak var toPicker: UIPickerView!
    @IBOutlet weak var convertButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func checkEnabledToChange() {
        
    }
    
    @IBAction func exchange(_ sender: Any) {
        Task {
            
        }
    }
    

}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        Currency.allCases.count
    }
    
    
}

