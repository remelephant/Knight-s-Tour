//
//  ViewController.swift
//  Knight's Example
//
//  Created by Vahagn Gevorgyan on 3/29/17.
//  Copyright © 2017 Vahagn Gevorgyan. All rights reserved.
//

import UIKit
import AVFoundation

class mainViewController: UIViewController {
    
    let board = Board()
    var someNum: Int?
    let support = Support()
    var arrayOf = [Int: UITapGestureRecognizer]()
    var myDict = [Int: UIView]()
    var someBool: Bool = false
    
    
    func addButton(y: CGFloat, text: String) -> UIButton {
        let button = UIButton(type: UIButtonType.roundedRect)
        button.frame = CGRect(origin: CGPoint(x: view.bounds.width/2 - 50, y: y), size: CGSize(width: 100, height: 20))
        button.setTitle(text, for: UIControlState.normal)
        return button
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        board.size = 8
        
        let button = addButton(y: 40, text: "Start again")
        let demo = addButton(y: 60, text: "Demo")
        
        if myDict.isEmpty {
            myDict = board.createSquares()
            self.view.addSubview(button)
            self.view.addSubview(demo)
            button.addTarget(self, action: #selector (start), for: UIControlEvents.touchUpInside)
            demo.addTarget(self, action: #selector (demoMode), for: UIControlEvents.touchUpInside)
        }
        
        for i in 1...board.size {
            for j in 1...board.size {
                let number = board.intForDict(first: i, second: j)
                view.addSubview(myDict[number]!)
                myDict[number]?.tag = number
                let gesture = UITapGestureRecognizer(target: self, action: #selector (recognize))
                arrayOf[number] = gesture
            }
        }
        
        for i in 1...board.size {
            for j in 1...board.size {
                let number = board.intForDict(first: i, second: j)
                myDict[number]?.addGestureRecognizer(arrayOf[number]!)
            }
        }
        
        
        
        if someNum != nil {
        
        switch support.example {
        case .Lose:
            lose()
            print("Lose")
        case .Win:
            print("Win")
        case .Normal:
            support.printPossiableSteps(dict: myDict, position: someNum!, inDemoMode: false)
            print("Normal")
        case .Demo:
            support.printPossiableSteps(dict: myDict, position: someNum!, inDemoMode: true)
            print("Demo")
            
            }
        }
        print("out of switch")
    }
    
    func lose() {
        let alertController = UIAlertController(title: "Game over", message:
            "Hello, world!", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Start again", style: UIAlertActionStyle.default, handler: { (action) in
            self.clear()
            self.support.example = .Normal
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func start(sender: UIButton) {
        clear()
        support.example = .Normal
    }
    
    func clear() {
        myDict = [:]
        arrayOf = [:]
        support.clear()
        someNum = nil
        someBool = false
        self.view.subviews.forEach({ $0.removeFromSuperview() })
        self.viewDidLoad()
    }
    
    func recognize(t: UITapGestureRecognizer) {
        
        if let index = arrayOf.values.index(of: t) {
            let key = arrayOf.keys[index]
            someNum = key
            self.viewDidLoad()
        } else {
            print("Error")
        }
    }
    
    func demoMode() {
        
//        if support.example == .Demo {
//            clear()
//        } else {
//            clear()
//            support.example = .Demo
//            self.viewDidLoad()
//        }
        
        clear()
        support.example = .Demo
        self.viewDidLoad()
    }
    
    override var shouldAutorotate: Bool {
        return false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}