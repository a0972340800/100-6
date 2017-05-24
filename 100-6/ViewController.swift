//
//  ViewController.swift
//  100-6
//
//  Created by john john on 2017/5/24.
//  Copyright © 2017年 John. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDataSource, UITableViewDelegate {

    var number = [0,1,2,3,4,5,6,7,8,9]
    var numberAry: [[Int]] = []
    var question = [0,0,0,0]
    var answerString: [String] = []
    var answer = [0,0,0,0]
    var APoint = 0
    var BPoint = 0
    var sumOfTime = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numberAry.append(number)
        numberAry.append(number)
        numberAry.append(number)
        numberAry.append(number)

        initGame()
        
        self.view.backgroundColor = UIColor.white
        
        picker.dataSource = self as UIPickerViewDataSource
        picker.delegate = self as UIPickerViewDelegate
        
        recordTable.dataSource = self
        recordTable.delegate = self
        
        setupView()
        
    }
    
    func initGame() {
        
        number = [0,1,2,3,4,5,6,7,8,9]
        
                print("original number array = ",number)
        
        ABLabel.text = "0 A 0 B"
        timeLabel.text = "剩餘次數 : 10"
        sumOfTime = 10
        for i in 0 ... (question.count - 1) {
            
            let n = Int(arc4random()) % number.count
            
            question[i] = number[n]
            
            number.remove(at: n)
        }
                print("final number arrahy = ", number)
                print(question)
    }

    let timeLabel: UILabel = {
        let tl = UILabel()
        tl.translatesAutoresizingMaskIntoConstraints = false
        tl.backgroundColor = UIColor.clear
        tl.font = UIFont.boldSystemFont(ofSize: 20)
        tl.textAlignment = .left
        tl.text = "hello"
        return tl
    }()
    
    let ABLabel: UILabel = {
        let abl = UILabel()
        abl.translatesAutoresizingMaskIntoConstraints = false
        abl.backgroundColor = UIColor.clear
        abl.font = UIFont.boldSystemFont(ofSize: 35)
        abl.textAlignment = .center
        abl.text = "hahahello."
        return abl
    }()
    
    let makeSureBtn: UIButton = {
        let msb = UIButton(type: .system)
        msb.translatesAutoresizingMaskIntoConstraints = false
        msb.setTitle("確定", for: .normal)
        msb.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        msb.backgroundColor = UIColor.clear
        msb.addTarget(self, action: #selector(pushDoing), for: .touchUpInside)
        return msb
    }()
    
    let picker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.backgroundColor = UIColor.clear
        return picker
    }()
    
    let recordTable: UITableView = {
        let rt = UITableView()
        rt.translatesAutoresizingMaskIntoConstraints = false
        rt.backgroundColor = UIColor.clear
        rt.register(recordCell.self, forCellReuseIdentifier: "cell")
        return rt
    }()
    
    func setupView() {
        
        view.addSubview(timeLabel)
        view.addSubview(ABLabel)
        view.addSubview(makeSureBtn)
        view.addSubview(picker)
        view.addSubview(recordTable)
        
        timeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        timeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        timeLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20).isActive = true
        timeLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true

        ABLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor).isActive = true
        ABLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        ABLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20).isActive = true
        ABLabel.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        picker.topAnchor.constraint(equalTo: ABLabel.bottomAnchor).isActive = true
        picker.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        picker.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        picker.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        makeSureBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        makeSureBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        makeSureBtn.widthAnchor.constraint(equalToConstant: 45).isActive = true
        makeSureBtn.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        recordTable.topAnchor.constraint(equalTo: picker.bottomAnchor).isActive = true
        recordTable.bottomAnchor.constraint(equalTo: makeSureBtn.topAnchor).isActive = true
        recordTable.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        recordTable.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 4
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return String(describing: numberAry[0][row])
        }else if component == 1 {
            return String(describing: numberAry[1][row])
        }else if component == 2 {
            return String(describing: numberAry[2][row])
        }
        return String(describing: numberAry[3][row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch (component) {
        case 0:
            answer[0] = numberAry[0][row]
        case 1:
            answer[1] = numberAry[1][row]
        case 2:
            answer[2] = numberAry[2][row]
        case 3:
            answer[3] = numberAry[3][row]
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answerString.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if answerString.count != 0 {
            cell.textLabel?.text = answerString[indexPath.row]
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return  1
    }
    
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let btn1 = UIAlertAction(title: "結束", style: .default) { (btn1) in
            self.makeSureBtn.isEnabled = false
        }
        let btn2 = UIAlertAction(title: "再玩一次", style: .default) { (btn2) in
            self.initGame()
            self.answerString.removeAll()
            self.recordTable.reloadData()
        }
        alert.addAction(btn1)
        alert.addAction(btn2)
        present(alert, animated: true, completion: nil)
    }
    
    func pushDoing() {
        APoint = 0
        BPoint = 0
        
        if answer[0] == answer [1] || answer[0] == answer[2] || answer[0] == answer[3] || answer[1] == answer[2] || answer[1] == answer[3] || answer[2] == answer[3] {
            let alert = UIAlertController(title: "Oops", message: "數字必須全部相異唷!", preferredStyle: .alert)
            let btn = UIAlertAction(title: "好", style: .default, handler: { (btn) in
                
            })
            alert.addAction(btn)
            present(alert, animated: true, completion: nil)
        }else{
            for i in 0 ... 3 {
                
                for n in 0 ... 3 {
                    
                    if n == i {
                        if answer[n] == question[i] {
                            APoint += 1
                        }
                    }else{
                        if answer[n] == question[i] {
                            BPoint += 1
                        }
                    }
                }
            }
            sumOfTime -= 1
            if APoint == 4 && sumOfTime > 0 {
                alert(title: "恭喜", message: "猜對了！")
            }else if sumOfTime == 0 && APoint < 4 {
                alert(title: "真可惜", message: "沒猜中...加油！加油！")
            }
            
            ABLabel.text = "\(APoint) A \(BPoint) B"
            timeLabel.text = "剩餘次數 : \(sumOfTime)"
            
            let string1 = "第\(10 - sumOfTime)次 : \(takeOutNumber()) , \(ABLabel.text!)"
            
            answerString.append(string1)
            
            self.recordTable.reloadData()            
        }
    }
    
    func takeOutNumber() -> String {
        
        var numberString = ""
        for i in 0 ..< answer.count {
            numberString = numberString + "\(answer[i])"
        }
        return numberString
    }
}

class recordCell: UITableViewCell {
    
}

