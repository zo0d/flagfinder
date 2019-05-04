//
//  ViewController.swift
//  flagfinder
//
//  Created by BJ on 2019-05-04.
//  Copyright © 2019 BJ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var flag1: UIButton!
    @IBOutlet weak var flag2: UIButton!
    @IBOutlet weak var flag3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctFlag = 0
    var tries = 0
    var newGame:  Bool  {
        return tries == 10
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action
            , target: self, action: #selector(alertScore))
        
        flag1.layer.borderWidth = 1
        flag2.layer.borderWidth = 1
        flag3.layer.borderWidth = 1
        
        flag1.layer.borderColor = UIColor.black.cgColor
        flag2.layer.borderColor = UIColor.black.cgColor
        flag3.layer.borderColor = UIColor.black.cgColor
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        nextQuestion()
    }
    
    func nextQuestion(action: UIAlertAction! = nil) {
        if newGame {
            score = 0
            tries = 0
        }
        
        countries.shuffle()
        
        flag1.setImage(UIImage(named: countries[0]), for: .normal)
        flag2.setImage(UIImage(named: countries[1]), for: .normal)
        flag3.setImage(UIImage(named: countries[2]), for: .normal)
        
        correctFlag = Int.random(in: 0...2)
        
        title = "SCORE: \(score) - CHOOSE: \(countries[correctFlag].uppercased())"
    }
    
    @objc func alertScore() {
        let ac = UIAlertController(title: "", message: "Your score is \(score).", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default))
        present(ac, animated: true)
    }
    
    @IBAction func touchFlag(_ sender: UIButton) {
        var title: String
        
        if sender.tag == correctFlag {
            title = "Correct"
            score += 1
            tries += 1
        } else {
            title = "Wrong... That's \(countries[sender.tag].capitalized)."
            if score != 0 {
                score -= 1
            }
            tries += 1
        }
        
        if newGame {
            let ac = UIAlertController(title: title, message: "Your final score is \(score).", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "New Game", style: .default, handler: nextQuestion))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: title, message: "Your score is \(score).", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: nextQuestion))
            present(ac, animated: true)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Disppose of any resources that can be recreated.
    }
    
    
}

