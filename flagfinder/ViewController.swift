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
    var previous: UILabel?
    
    var newGame:  Bool  {
        return tries == 10
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action
            , target: self, action: #selector(alertScore))
        
        let label1 = UILabel()
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.backgroundColor = UIColor.red
        label1.text = "NOW"
        label1.sizeToFit()
        
        let label2 = UILabel()
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.backgroundColor = UIColor.cyan
        label2.text = "SHE"
        label2.sizeToFit()
        
        let label3 = UILabel()
        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.backgroundColor = UIColor.yellow
        label3.text = "PROUD"
        label3.sizeToFit()
        
        let label4 = UILabel()
        label4.translatesAutoresizingMaskIntoConstraints = false
        label4.backgroundColor = UIColor.green
        label4.text = "OF"
        label4.sizeToFit()
        
        let label5 = UILabel()
        label5.translatesAutoresizingMaskIntoConstraints = false
        label5.backgroundColor = UIColor.orange
        label5.text = "ME"
        label5.sizeToFit()
        
        view.addSubview(label1)
        view.addSubview(label2)
        view.addSubview(label3)
        view.addSubview(label4)
        view.addSubview(label5)
        
//        let viewsDictionary = ["label1": label1, "label2": label2, "label3": label3, "label4": label4, "label5": label5]
//
//        let metrics = ["labelHeight": 88]

        
//        for label in viewsDictionary.keys {
//            view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "H:|[\(label)]|", options: [], metrics: nil, views: viewsDictionary))
//        }
        
        
//        view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "V:|[label1(labelHeight@999)]-[label2(labelHeight)]-[label3(labelHeight)]-[label4(labelHeight)]-[label5(labelHeight)]->=10-|", options: [], metrics: metrics, views: viewsDictionary))
        
//        for label in [label1, label2, label3, label4, label5] {
//            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
//            label.trailingAnchor.constraint (equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
//            label.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.2).isActive = true
//            
//            if let previous = previous {
//                label.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 10).isActive = true
//            } else {
//                label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
//            }
//            
//            previous = label
//        }

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
        
        flag1.transform = .identity
        flag2.transform = .identity
        flag3.transform = .identity
        
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
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [], animations: {
            sender.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
        })
        
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

