//
//  ViewController.swift
//  Simon
//
//  Created by Dan Morton on 6/25/19.
//  Copyright © 2019 Personal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet var squares: [UIView]!
    var count = 0
    var litSquares : [Int] = []
    var litSequence : [Int] = []
    var userTurn = false;
    var currPress = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func startButtonPressed(_ sender: Any) {
        if (!userTurn) {
            self.triggerSquare()
        }
    }
    
    func triggerSquare() {
        let square = getNextSquare()
        squares[square].alpha = 0.5;
        _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
            
            self.squares[square].alpha = 1.0;
            self.count = self.count + 1;
            if (self.count < 4) {
                self.triggerSquare()
            } else {
                self.count = 0;
                self.litSequence = self.litSquares
                self.userTurn = true;
                self.litSquares.removeAll()
            }
        }
    }
    
    func getNextSquare() -> Int {
        while (true) {
            let square = Int(arc4random_uniform(4))
            if (self.litSquares.contains(square)) {
                continue
            } else {
                self.litSquares.append(square)
                return square;
            }
        }
    }
    
    @IBAction func squareTapped(view sender: UIView) {
        if (userTurn) {
            if (view.accessibilityLabel == "\(self.litSquares[currPress])") {
                self.messageLabel.text = "Correct!"
                self.currPress = self.currPress + 1
                if (self.currPress == 3) {
                    self.currPress = 0
                    self.userTurn = false
                    self.litSequence = []
                    self.messageLabel.text = "Press Start"
                }
            } else {
                self.messageLabel.text = "Press Start"
                self.currPress = 0
                self.userTurn = false
                self.litSequence = []
            }
        }
    }
    

}

