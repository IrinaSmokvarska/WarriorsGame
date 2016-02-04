//
//  ViewController.swift
//  ExerciseOOP-
//
//  Created by Darko Spasovski on 2/3/16.
//  Copyright © 2016 Irina Smokvarska. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {

    @IBOutlet weak var playerOneImg: UIImageView!
    
    
    @IBOutlet weak var playerTwoImg: UIImageView!
    
    @IBOutlet weak var printLbl: UILabel!
    
    @IBOutlet weak var player1BtnOut: UIButton!
    
    @IBOutlet weak var player2BtnOut: UIButton!
    
    @IBOutlet weak var playOneWarrior: UIImageView!
   
    @IBOutlet weak var playTwoOrc: UIImageView!
    
    var attackSound: AVAudioPlayer!
    var deadSound: AVAudioPlayer!
    var bgMusic: AVAudioPlayer!
    
    var playerOne: Character!
    var playerTwo: Character!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("beep3", ofType: "mp3")
        
        let soundUrl = NSURL(fileURLWithPath: path!)
        do {
            try attackSound = AVAudioPlayer(contentsOfURL: soundUrl)
            attackSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        let patH = NSBundle.mainBundle().pathForResource("beep10", ofType: "mp3")
        
        let soundURl = NSURL(fileURLWithPath: patH!)
        do {
            try deadSound = AVAudioPlayer(contentsOfURL: soundURl)
            deadSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        let soundFilePath = NSBundle.mainBundle().pathForResource("8bit", ofType: "mp3")
        let soundFileURL = NSURL(fileURLWithPath: soundFilePath!)
        do {
            try bgMusic = AVAudioPlayer(contentsOfURL: soundFileURL)
            bgMusic.numberOfLoops = -1
            bgMusic.play()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
      
        
      playerOne = Character(startingHp: 100, attackPwr: 30, name: "Irina")
      playerTwo = Character(startingHp: 200, attackPwr: 10, name: "Darko")
    
    }
    
    @IBAction func playOneWarrorPressed(sender: AnyObject) {
//        playerOneImg.hidden = true
//        playOneWarrior.hidden = false
        
        playerOneImg.image = UIImage(named: "player")

//        UIImage* flippedImage = [UIImage imageWithCGImage:sourceImage.CGImage
//            scale:sourceImage.scale
//            orientation:UIImageOrientationUpMirrored];
        
        let image: UIImage = UIImage(CGImage: playerOneImg.image!.CGImage!, scale: playerOneImg.image!.scale, orientation: UIImageOrientation.UpMirrored)
        playerOneImg.image = image
    }
    
    @IBAction func playOneOrcPressed(sender: AnyObject) {
//        playOneWarrior.hidden = true
//        playerOneImg.hidden = false
        
        playerOneImg.image = UIImage(named: "enemy")
        
        
    }
    
    @IBAction func playTwoWarriorPressed(sender: AnyObject) {
//        playerTwoImg.hidden = false
//        playTwoOrc.hidden = true
        
        playerTwoImg.image = UIImage(named: "player")
        
    }
    
    @IBAction func playTwoOrcPressed(sender: AnyObject) {
//        playerTwoImg.hidden = true
//        playTwoOrc.hidden = false
//        
        playerTwoImg.image = UIImage(named: "enemy")

        if let img = playerTwoImg.image{
        let image: UIImage = UIImage(CGImage: img.CGImage!, scale: img.scale, orientation: UIImageOrientation.UpMirrored)
        playerTwoImg.image = image
        }
    }
  
    
    
    @IBAction func onPlayerOneBtnPressed(sender: AnyObject) {
        playSoundAttack()
        if playerTwo.attemptAttack(playerOne.attackPower) {
            printLbl.text = " \(playerOne.name) attacked \(playerTwo.name) for \(playerTwo.hp) HP"
            
        } else {
            printLbl.text = "Attack was unsuccessful"
        }
        
        
        player2BtnOut.enabled = false
        let delayTime =  dispatch_time(DISPATCH_TIME_NOW, Int64(3 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            self.player2BtnOut.enabled = true
        }
        
        whoWon()
    
    }
    @IBAction func onPlayerTwoBtnPressed(sender: AnyObject) {
        playSoundAttack()
        if playerOne.attemptAttack(playerTwo.attackPower) {
            printLbl.text = "\(playerTwo.name) attacked \(playerOne.name) for \(playerOne.hp) HP"
            
           
        } else {
            printLbl.text = "Attack was unsuccessful"
        }
        
        player1BtnOut.enabled = false
        let delayTime =  dispatch_time(DISPATCH_TIME_NOW, Int64(3 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            self.player1BtnOut.enabled = true
        }

        
        whoWon()
    }
    
    func whoWon() {
        if !playerOne.isAlive {
            playSoundDead()
            printLbl.text = "Darko Won!"
            
            restartGame()
        } else if !playerTwo.isAlive {
            playSoundDead()
            printLbl.text = "Irina Won!"
            
            restartGame()
        }
    }
    
    func restartGame() {
        playerOne = Character(startingHp: 100, attackPwr: 30, name: "Irina")
        playerTwo = Character(startingHp: 200, attackPwr: 10, name: "Darko")
        
    }
    func playSoundDead() {
        if deadSound.playing {
            deadSound.stop()
        }
        deadSound.play()
        
    }
    
    func playSoundAttack() {
        if attackSound.playing {
            attackSound.stop()
        }
        attackSound.play()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

