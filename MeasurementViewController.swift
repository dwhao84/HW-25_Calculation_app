//
//  MeasurementViewController.swift
//  HW#28_Calculation
//
//  Created by Dawei Hao on 2023/5/3.
//

import UIKit

class MeasurementViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource{
    
    //顯示行數
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //指定component的行數
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return lengthUnitName.count
    }
    //透過UIPickerView顯示陣列裡面的標題
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return lengthUnitName[row]
        }
    //當在pickerView裡面的文字被選到了之後，會產生相對應的文字
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //當TextField在編輯的時候，TextField的文字會等於unitArray裡面的內容
        if unitTypeTextField.isEditing {
            unitTypeTextField.text = unitArray[row]
            //設定的空字串會等於unitArray裡面的內容
            inputUnit = unitArray[row]
            print("input")
        } else {
            unitTypeChangedTextField.text = unitArray[row]
            outputUnit = unitArray[row]
            print("output")
        }
    }
    
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var outputTextField: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var title2Label: UILabel!
    @IBOutlet weak var title3Label: UILabel!
    @IBOutlet weak var countButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var unitTypeTextField: UITextField!
    @IBOutlet weak var unitTypeChangedTextField: UITextField!
    @IBOutlet weak var unitPickerView: UIPickerView!
    
    //建立出單位縮寫的array
    let unitArray = ["km","m","cm","mm","mi","nm","yd","in","ft"]
    //建立完整單位名稱的array
    let lengthUnitName = ["Kilometers","Meters","Centimeters","Millimeters","Miles","Nautical Miles","Yards","Inches","Feet"]
    
    //預先設定尚未輸入的文本內容為空字串
    var inputUnit = ""
    var outputUnit = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //代入TextField delegate
        unitTypeChangedTextField.delegate = self
        unitTypeTextField.delegate = self
        inputTextField.delegate = self
        outputTextField.delegate = self
        
        //代入PickerView delegate & dataSource
        unitPickerView.delegate = self
        unitPickerView.dataSource = self
        
        //將點擊的鍵盤類型設定為數字鍵盤
        outputTextField.keyboardType = .numberPad
        inputTextField.keyboardType = .numberPad

        //將單位轉換的TextField轉為unitPickView
        unitTypeTextField.inputView = unitPickerView
        unitTypeChangedTextField.inputView = unitPickerView
        
        //inputUnit ＝ cm"
        inputUnit = unitArray[3]
        //outputUnit ＝ "Feet"
        outputUnit = unitArray[9]
        
        //textField的字串轉為inputUnit
        unitTypeTextField.text = inputUnit
        //textField的字串轉為outputUnit
        unitTypeChangedTextField.text = outputUnit
        
        //點擊畫面之後，自動收鍵盤
        initialSetUp ()

    }
    //將inputTextField為第一個響應者FirstResponder
    @IBAction func didEndOnExit(_ sender: Any) {
        inputTextField.becomeFirstResponder()
    }
    
    //點擊textField之後，開始執行
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("textFieldShouldBeginEditing")
        return true
    }
    
    //新增點擊畫面時會將視窗自動隱藏。
    private func initialSetUp () {
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
    }
    //新增收鍵盤的功能
    @objc private func hideKeyboard() {
        self.view.endEditing(true)
        print("endEditing")
    }
    //撰寫一個Function，建立一個inputText等於inputTextField加上optional
    //input會等於inputText的值，並加上optional，因為不知道會不會有inputext
    func updatedUI () {
        let inputText = inputTextField.text!
        let input = Double(inputText)!
                //將unitArray轉換為UnitLength的method
                func unitLength(unitSource: String) -> UnitLength {
                    var unitLength: UnitLength
                    switch unitSource {
                        case "km": unitLength = UnitLength.kilometers
                        case "m": unitLength = UnitLength.meters
                        case "mm": unitLength = UnitLength.millimeters
                        case "mi": unitLength = UnitLength.miles
                        case "nm": unitLength = UnitLength.nauticalMiles
                        case "yd": unitLength = UnitLength.yards
                        case "in": unitLength = UnitLength.inches
                        case "ft": unitLength = UnitLength.feet
                        default: unitLength = UnitLength.centimeters
                    }
                    return unitLength
                }
        //將Measurement轉換input的單位存到inputUnit，套入Measurement的方法
        let inputUnit = Measurement(value: input, unit: unitLength(unitSource: inputUnit))
        //將Measurement轉換output的單位存到outputUnit，套入Measurement的方法
        let outputUnit = inputUnit.converted(to: unitLength(unitSource: outputUnit))
        //讓outputUnit的值存到outputText
        let outputText = outputUnit.value
        //再將outText轉換小數點第一位，並轉換成String
        outputTextField.text = String(format: "%.1f", outputText)
    }
   
    
    //點擊CountButton，並帶入updatedUI()
    @IBAction func countButtonTapped(_ sender: Any) {
        updatedUI()
    }
    //點擊resetButton，將數字預設為空字串。
    @IBAction func resetButtonTapped(_ sender: Any) {
        inputTextField.text = ""
        outputTextField.text = ""
        unitTypeTextField.text = unitArray[3]
        unitTypeChangedTextField.text = unitArray[9]
    }
}
