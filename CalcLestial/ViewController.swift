//
//  ViewController.swift
//  CalcLestial
//
//  Created by Tung Ly on 4/24/16.
//  Copyright © 2016 Tung Ly. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var runningNumber = ""
    
    var operation = ""
    
    var rightValue = ""
    
    var leftValue = ""
    
    var res = "0"
    
    var result = ""
    
    var buttonSound: AVAudioPlayer!

    
    @IBOutlet weak var outputLabel: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        
        let soundURL = NSURL(fileURLWithPath: path!)
        do {
            
            try buttonSound = AVAudioPlayer(contentsOfURL: soundURL)
            
            buttonSound.prepareToPlay()
            
        } catch let error as NSError {
            
            print(error.debugDescription)
        
        }
    
    }    
    
    @IBAction func onEqualPress(sender: UIButton) {
        
        if operation != ""{
            
            playSound()
            
            operationsFunc(operation, num: Int(leftValue)!, tempnum: Int(rightValue)!)
        
        }
        
    }
    
    func operationsFunc(operation1:String, num:Int, tempnum:Int){
        
        outputLabel.text  = performOperation(operation1, num1: num, num2: tempnum)
        
        runningNumber = outputLabel.text!
        
        leftValue = runningNumber
        
        rightValue = ""
       
        operation = ""
    }

    @IBAction func onClearPress(sender: UIButton) {
        
        restartCalculator()
        
    }
    
    func performOperation(oper:String,num1:Int, num2:Int) -> String{
        
        switch oper{
        
        case "add" : res = "\(Double(leftValue)! + Double(rightValue)!)"
            return res
        
        case "sub" : res = "\(Double(leftValue)! - Double(rightValue)!)"
            return res
        
        case "div" :
            if num2 == 0{
                return "0"
    
            }else{
                res = "\(Double(leftValue)! / Double(rightValue)!)"
                return res
            }
        
        case "mul" : res = "\(Double(leftValue)! * Double(rightValue)!)"
            return res
        
        default : return ""
        }
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    func playSound() {
        if buttonSound.playing {
            buttonSound.stop()
        }
        
        buttonSound.play()
    }
    
    func restartCalculator() {
        playSound()
        runningNumber = ""
        operation = ""
        res = ""
        rightValue = ""
        outputLabel.text = "0"
    }
    
    
    func decideOperation(num:Int){
        
        switch num{
        case 50 : operation = "add"
        case 60 : operation = "sub"
        case 70 : operation = "div"
        case 80 : operation = "mul"
        default : operation = ""
        
        }
        
    }
    
    
    @IBAction func NumAndOpButtonPressed(sender: UIButton) {
                
        playSound()
        
        if sender.tag == 50 || sender.tag == 60 || sender.tag == 70 || sender.tag == 80{
            if operation == ""{
                decideOperation(sender.tag)
            }else{
                operationsFunc(operation, num: Int(leftValue)!, tempnum: Int(rightValue)!)
                
            }
            
        }else{
            
            if operation == ""{
                runningNumber += "\(sender.tag)"
                leftValue = runningNumber
                outputLabel.text = String(runningNumber)
                
            }else{
                
                rightValue += "\(sender.tag)"
                outputLabel.text = String(rightValue)
            }
        }
    }
}

