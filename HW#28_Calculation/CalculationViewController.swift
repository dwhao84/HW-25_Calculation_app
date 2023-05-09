//
//  CalculationViewController.swift
//  HW#28_Calculation
//
//  Created by Dawei Hao on 2023/5/1.
//

import UIKit

class CalculationViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var spentLabel: UILabel!
    @IBOutlet weak var tipsLabel: UILabel!
    @IBOutlet weak var numberOfPeopleLabel: UILabel!
    @IBOutlet weak var countButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var averagePaidLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var spentTextField: UITextField!
    @IBOutlet weak var tipsTextField: UITextField!
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var numberOfPeopleTextField: UITextField!
    @IBOutlet weak var totalSpentLabel: UILabel!
    @IBOutlet weak var totalSpentValue: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //讓TextField加上delegate帶入協定，才有辦法將textField其他功能帶入
        spentTextField.delegate = self
        tipsTextField.delegate = self
        numberOfPeopleTextField.delegate = self
        
        //設定UITextField的鍵盤模式為數字鍵盤。
        spentTextField.keyboardType = .numberPad
        tipsTextField.keyboardType = .numberPad
        numberOfPeopleTextField.keyboardType = .numberPad
        
        initialSetUp()
    }
    //新增唯讀功能和初始設定，當點擊畫面時，鍵盤會自動隱藏。
    private func initialSetUp () {
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
    }
    //新增唯讀功能:隱藏鍵盤
    @objc private func hideKeyboard() {
        self.view.endEditing(true)
        print("endEditing")
    }
    
    //UITextField開始編緝
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("textFieldShouldBeginEditing")
        return true
    }
    
    //UITextField按enter
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textFieldShouldReturn")
        return true
    }
    
    
    //點擊countButton，並計算出平均每個人要出多少錢(包含小費)
    @IBAction func countButtonTapped(_ sender: Any) {
        //if let解包，運用optional blinding將未輸入的數字解開
        if let spent = Double(spentTextField.text!),
           //定義tipsPercentage為小費費用的新常數，型別為Double
            let tipsPercentage = Double(tipsTextField.text!),
           //定義numberOfPeople為分錢人的數新常數，型別為Double
           let numberOfPeople = Double(numberOfPeopleTextField.text!) {
            //定義average為每人所必須出的費用為新的常數，並運用operator算出費用，型別為Double
            let average = ((spent * tipsPercentage * 0.01)  + (spent * 1)) / numberOfPeople
            //定義totalSpentMoney為金額再加上小費的金額的計算式，型別為Double
            let totalSpentMoney = (( spent * tipsPercentage * 0.01 ) + spent)
            //檢查是否點擊成功
            print("countButtonTapped")
            //將average的型別從Double轉換到String，並將resultLabel轉換字串，並運用format將"%.1f"讓average的數字變為小數點第一位。
            resultLabel.text = String(format:"%.1f", average)
            //型別轉換Double to String
            totalSpentValue.text = String(totalSpentMoney)
            
        }
    }
    //點擊resetButton，將數字重新歸0
    @IBAction func resetButtonTapped(_ sender: Any) {
        //將以下textField變為空字串
        spentTextField.text = ""
        tipsTextField.text = ""
        numberOfPeopleTextField.text = ""
        resultLabel.text = "0.0"
        totalSpentValue.text = "0.0"
        //檢查是否點擊成功
        print("resetButtonTapped")
    }

    //spentTextField when click the reture keyboard will dismiss
    @IBAction func spentTextFieldDismissKeyboard(_ sender: Any) {
        view.endEditing(true)
        print("spentTextFieldDismissKeyboard")
    }
    //tipsTextField when click the reture keyboard will dismiss
    @IBAction func tipsTextFieldDismissKeyboard(_ sender: Any) {
        view.endEditing(true)
        print("tipsTextFieldDismissKeyboard")
    }
    //numberOfTextField when click the reture keyboard will dismiss
    @IBAction func numberOfTextFieldDismissKeyboard(_ sender: Any) {
        view.endEditing(true)
        print("numberOfTextFieldDismissKeyboard")
        
    }
}
