//
//  ViewController.swift
//  Kenny-Game-New
//
//  Created by Murad on 16.11.2023.
//

import UIKit

class ViewController: UIViewController {
    
    //label image atama
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var hightscoreLabel: UILabel!
    @IBOutlet weak var kenny1: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny9: UIImageView!
    
    //Variables
    
    var hideTimer = Timer()
    var timer = Timer()
    var counter = 0
    var score = 0
    var kennyArray = [UIImageView()]
    var hightScore = 0
    var isKennyActive = false
    
    //views
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //HightScore check
        
        let storedHighScore = UserDefaults.standard.object(forKey: "hightscore")
        
        if storedHighScore == nil {
            hightScore = 0
            hightscoreLabel.text = "Hightscore: \(self.hightScore)"
        }
        
        if let newScore = storedHighScore as? Int {
            hightScore = newScore
            hightscoreLabel.text = "Hightscore: \(hightScore)"
        }
        
        //kennye tiklamayi aktif hala geterir
        kenny1.isUserInteractionEnabled = true
        kenny2.isUserInteractionEnabled = true
        kenny3.isUserInteractionEnabled = true
        kenny4.isUserInteractionEnabled = true
        kenny5.isUserInteractionEnabled = true
        kenny6.isUserInteractionEnabled = true
        kenny7.isUserInteractionEnabled = true
        kenny8.isUserInteractionEnabled = true
        kenny9.isUserInteractionEnabled = true
        
        scoreLabel.text = "Score: \(score)"
        
        //recognizere atama islemi sonra cagirmak icin increase functionun burda atanmasi
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        //burada ise cagirilmasi functionlarin isletilmesi
        kenny1.addGestureRecognizer(recognizer1)
        kenny2.addGestureRecognizer(recognizer2)
        kenny3.addGestureRecognizer(recognizer3)
        kenny4.addGestureRecognizer(recognizer4)
        kenny5.addGestureRecognizer(recognizer5)
        kenny6.addGestureRecognizer(recognizer6)
        kenny7.addGestureRecognizer(recognizer7)
        kenny8.addGestureRecognizer(recognizer8)
        kenny9.addGestureRecognizer(recognizer9)
        
        //arraya atama etdik cunki icinde gezine bilelim diye
        kennyArray = [kenny1, kenny2, kenny3, kenny4, kenny5, kenny6, kenny7, kenny8, kenny9]
        //.appendle de ekleye biliriz
        
        //timers
        counter = 10
        timeLabel.text = String(counter)
        //timer ve hidetimer burda hazirlanir
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
        //hideknny func cagirildi
        hideKenny()
        
            }
    
    
    
    //functions
    @objc func hideKenny() {
            for kenny in kennyArray {
                kenny.isHidden = true
            }
            let random = Int(arc4random_uniform(UInt32(kennyArray.count - 1)))
            kennyArray[random].isHidden = false
            isKennyActive = true // Set the flag to indicate that Kenny is active
        }
        
        @objc func increaseScore() {
            if isKennyActive {
                score += 1
                scoreLabel.text = "Score: \(score)"
                isKennyActive = false // Reset the flag after a valid tap
            }
        }
    
    @objc func showAllKennys() {
           for kenny in kennyArray {
               kenny.isHidden = false
           }
       }

       @objc func countDown() {
           counter -= 1
           timeLabel.text = String(counter)

           if counter == 0 {
               timer.invalidate()
               hideTimer.invalidate()
    
               
               // Hight Score
               if score > hightScore {
                   hightScore = score
                   hightscoreLabel.text = "Hight Score: \(hightScore)"
                   UserDefaults.standard.setValue(hightScore, forKey: "highscore")
               }

               // Alert area
               let alert = UIAlertController(title: "Time's up!", message: "Do you want to play again?", preferredStyle: .alert)

               let okButton = UIAlertAction(title: "OK", style: .cancel) { _ in
                   self.showAllKennys()
               }

               let replayButton = UIAlertAction(title: "Replay", style: .default) { _ in
                   self.score = 0
                   self.scoreLabel.text = "Score: \(self.score)"
                   self.counter = 10
                   self.timeLabel.text = String(self.counter)

                   self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                   self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideKenny), userInfo: nil, repeats: true)
               }

               alert.addAction(okButton)
               alert.addAction(replayButton)
               present(alert, animated: true, completion: nil)
           }
       }

   
    }
    



