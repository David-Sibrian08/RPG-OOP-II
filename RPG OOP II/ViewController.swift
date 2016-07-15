//
//  ViewController.swift
//  RPG OOP II
//
//  Created by Sibrian on 7/11/16.
//  Copyright © 2016 Sibrian. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var attackUpdateLabel: UILabel!
    
    var attackSound: AVAudioPlayer!
    var punchSound: AVAudioPlayer!
    var deathSound: AVAudioPlayer!
    var gameMusic: AVAudioPlayer!
    
    @IBOutlet weak var trollHPLabel: UILabel!
    @IBOutlet weak var heroHPLabel: UILabel!

    @IBOutlet weak var muteButton: UIButton!
    @IBOutlet weak var unmuteButton: UIButton!
    
    @IBOutlet weak var restartButton: UIButton!
    
    @IBOutlet weak var heroAttackButton: UIButton!
    @IBOutlet weak var trollAttackButton: UIButton!
    
    var hero: Hero!
    var troll: Enemy!
    
    @IBOutlet weak var trollImageView: UIImageView!
    @IBOutlet weak var heroImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        initializeSounds()
        initializeGame()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initializeGame() {
        
        troll = Enemy(startingHP: 110, initialAttackPower: 16)
        hero = Hero(heroName: "Sir Nauticus", HP: 170, attackPower: 22)
        
        initializeHPLabel(troll, hero: hero)
        
        gameMusic.play()
    }
    
    @IBAction func trollAttackButtonPressed(sender: UIButton) {
        if punchSound.playing {
            punchSound.currentTime = 0
        }
        punchSound.play()
        
        if hero.attemptAttack(troll.attackPower) {
            attackUpdateLabel.text = "\(troll.type) attacked the hero for \(troll.attackPower) damage!!"
            heroHPLabel.text = "\(hero.HP) HP"
        } else {
            attackUpdateLabel.text = "The hero has dodged the attack!!! "
        }
        
        if hero.isDead {
            deathSound.play()
            
            attackUpdateLabel.text = "THE TROLL HAS VANQUISHED THE HERO!"
            heroHPLabel.hidden = true
            heroImageView.alpha = 0.5
            
            disableAndFadeButtons()
        }
    }
    
    @IBAction func heroAttackButtonPressed(sender: UIButton) {
        if attackSound.playing {
            attackSound.currentTime = 0
        }
        attackSound.play()
        
        if troll.attemptAttack(hero.attackPower) {
            attackUpdateLabel.text = "\(hero.name) attacks \(troll.type) for \(hero.attackPower) damage!"
            trollHPLabel.text = "\(troll.HP) HP"
        } else {
            attackUpdateLabel.text = "Troll has dodged the attack by \(hero.name)!!!"
        }
        
        if troll.isDead {
            deathSound.play()
            
            attackUpdateLabel.text = "\(hero.name) HAS VANQUISHED THE TROLL!"
            trollHPLabel.hidden = true
            trollImageView.alpha = 0.5
            
            disableAndFadeButtons()
        }
    }
    
    @IBAction func muteButtonPressed(sender: UIButton) {
        if gameMusic.playing {
            gameMusic.stop()
        }
        muteButton.hidden = true
        unmuteButton.hidden = false
    }
    
    @IBAction func unmuteButtonPressed(sender: UIButton) {
        if !gameMusic.playing {
            gameMusic.play()
        }
        muteButton.hidden = false
        unmuteButton.hidden = true
    }
    
    @IBAction func restartButtonPressed(sender: UIButton) {
        resetGame()
        
    }
    
    func resetGame() {
        initializeGame()
        
        gameMusic.currentTime = 0      //restart the menu music
        gameMusic.play()
        
        enableAndUnfadeButtons()
        
    }
    
    
    func initializeHPLabel(troll: Enemy, hero: Hero) {
        
        trollHPLabel.text = "\(troll.HP) HP"
        heroHPLabel.text = "\(hero.HP) HP"
    }
    
    func disableAndFadeButtons() {
        
        trollAttackButton.enabled = false
        trollAttackButton.alpha = 0.5
        
        heroAttackButton.enabled = false
        heroAttackButton.alpha = 0.5
        
        restartButton.hidden = false
    }
    
    func enableAndUnfadeButtons() {
        trollAttackButton.enabled = true
        trollAttackButton.alpha = 1.0
        
        heroAttackButton.enabled = true
        heroAttackButton.alpha = 1.0
        
        restartButton.hidden = true
        
        trollHPLabel.hidden = false
        trollImageView.alpha = 1.0
        
        heroHPLabel.hidden = false
        heroImageView.alpha = 1.0
    }
    
    func initializeSounds() {
        
        //initialize the attack sound (hero)
        let attackSoundPath = NSBundle.mainBundle().pathForResource("attack", ofType: "wav")
        let attackSoundURL = NSURL(fileURLWithPath: attackSoundPath!)
        
        do {
            try attackSound = AVAudioPlayer(contentsOfURL: attackSoundURL)
            attackSound.prepareToPlay()
        } catch let error as NSError {
            print(error.debugDescription)
        }
        
        //initialize the punch sound (troll)
        let punchSoundPath = NSBundle.mainBundle().pathForResource("punch", ofType: "mp3")
        let punchSoundURL = NSURL(fileURLWithPath: punchSoundPath!)
        
        do {
            try punchSound = AVAudioPlayer(contentsOfURL: punchSoundURL)
            punchSound.prepareToPlay()
        } catch let error as NSError {
            print(error.debugDescription)
        }
        
        //initialize the deathSound
        let deathSoundPath = NSBundle.mainBundle().pathForResource("death", ofType: "wav")
        let deathSoundURL = NSURL(fileURLWithPath: deathSoundPath!)
        
        do {
            try deathSound = AVAudioPlayer(contentsOfURL: deathSoundURL)
            deathSound.prepareToPlay()
        } catch let error as NSError {
            print(error.debugDescription)
        }
        
        //initialize the game music
        let gameMusicPath = NSBundle.mainBundle().pathForResource("menuMusic", ofType: "mp3")
        let gameMusicPathURL = NSURL(fileURLWithPath: gameMusicPath!)
        
        do {
            try gameMusic = AVAudioPlayer(contentsOfURL: gameMusicPathURL)
            gameMusic.prepareToPlay()
        } catch let error as NSError {
            print(error.debugDescription)
        }
        
    }

}

