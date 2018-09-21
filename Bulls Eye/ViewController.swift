//
//  ViewController.swift
//  Bulls Eye
//
//  Created by Milin Joshi on 9/20/18.
//  Copyright © 2018 Milin Joshi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var currentValue : Int = 50
    var targetValue : Int = 0
    var scoreValue = 0
    var roundValue = 0
    
    @IBOutlet weak var targetLabel : UILabel!
    @IBOutlet weak var scoreLabel : UILabel!
    @IBOutlet weak var roundLabel : UILabel!
    @IBOutlet weak var slider : UISlider!
    
    func updateLabels(){
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(scoreValue)
        roundLabel.text = String(roundValue)
    }
    
    func startNewRound() {
        roundValue += 1
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
        updateLabels()
    }
    
    func startNewGame() {
        scoreValue = 0
        roundValue = 0
        startNewRound()
    }

    @IBAction func startOver(){
        startNewGame()
    }
    
    @IBAction func sliderMoved(_ slider : UISlider){
        currentValue = lroundf(slider.value)
    }
    
    @IBAction func showAlert(){
        var difference : Int = abs(targetValue - currentValue)
        let title : String
//        var points : Int = 0
        
        if difference == 0 {
            title = "Perfect!"
//            points += 100
        }
        else if difference < 5 {
            title = "You almost had it !"
        }
        else if difference < 10 {
            title = "Pretty Good"
        }
        else {
            title = "Not even close"
        }
        
        let points = 100 - difference
        scoreValue +=  points
        let message = "You scored \(points) points"
        let alert = UIAlertController(title : title,
                                      message : message,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "OK",
                                   style: .default,
                                   handler : {
                                                action in self.startNewRound()
                                             }
                                    )
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        print("targetValue")
        print(targetValue)
        print("currentValue")
        print(currentValue)
        print("sliderValue")
        print(slider.value)
        print(difference)
        print(points)
        print("=========")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentValue = lroundf(slider.value)
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")!
        slider.setThumbImage(thumbImageNormal, for: .normal)
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")!
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        let trackLeftImage = UIImage(named: "SliderTrackLeft")!
        let trackLeftResizable =
            trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        let trackRightImage = UIImage(named: "SliderTrackRight")!
        let trackRightResizable =
            trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
        
        startNewGame()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

