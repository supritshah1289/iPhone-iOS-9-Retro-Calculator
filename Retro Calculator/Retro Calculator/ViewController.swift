//
//  ViewController.swift
//  Retro Calculator
//
//  Created by supritkumar shah on 12/13/15.
//  Copyright © 2015 supritkumar shah. All rights reserved.
//

import UIKit
import AVFoundation //Audio video foundation

class ViewController: UIViewController {
    
    
    enum Operation: String{
        
        case Add = "+"
        case Subtract = "-"
        case Multiply = "*"
        case Divide = "/"
        case Equal = "="
        case Empty = "empty"
    }
    
    //IB outlet is used when anything is change/updated
    @IBOutlet weak var outputLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    var runningNumber = ""    //variable to store numbers on screen
    var leftValStr = ""     //variable to store values on left side of an operator
    var rightValStr = ""    //variable to store value on right side of an operator
    var currentOperation = Operation.Empty
    var result = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    //Path variable have a value of sound file where it is located and its type
        
    let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
    let soundUrl = NSURL(fileURLWithPath: path!)
        
    //btnsound variable has been assigned 
        
        do{
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            btnSound.prepareToPlay()
        }
        catch let err as NSError{
            print(err.debugDescription)
        }
        
        
        
    }
    
    //function for all the button to find out which button is pressed
    
    @IBAction func numberPressed(btn: UIButton!){
        playSound()
        
        runningNumber += "\(btn.tag)" //updating runnning number and assigning to output label
        outputLbl.text = runningNumber
        
        
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }
    
    @IBAction func onAdditionPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    func processOperation(op: Operation){
        playSound()
        
        
        
    if currentOperation != Operation.Empty{
            //do math
            
            
        if runningNumber != "" {
            
            rightValStr = runningNumber
            runningNumber = ""
            if currentOperation == Operation.Multiply{
                result = "\(Double(leftValStr)! * Double(rightValStr)!)"
            } else if currentOperation == Operation.Divide{
                result = "\(Double(leftValStr)! / Double(rightValStr)!)"
            } else if currentOperation == Operation.Add {
                result = "\(Double(leftValStr)! + Double(rightValStr)!)"
            } else if currentOperation == Operation.Subtract {
                result = "\(Double(leftValStr)! - Double(rightValStr)!)"
            }
            
            leftValStr = result
            outputLbl.text = result
            }
            currentOperation = op
            
        }
        else {
            //this is the first time an operator has been pressed
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = op
            
        }
        
        
    }
    
    func playSound(){
        if btnSound.playing{
            btnSound.stop()
        }
        btnSound.play()
    }

}

