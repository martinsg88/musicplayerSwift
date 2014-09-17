//
//  LBViewController.swift
//  light bulb game
//
//  Created by Guilherme Martins on 9/12/14.
//  Copyright (c) 2014 com.gui.kenshuSwift. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class LBViewController: UIViewController, AVAudioPlayerDelegate {
    
    weak var waitTimer: NSTimer!
    weak var countTimer: NSTimer!
    var startTime: NSTimeInterval!

    var startButtonPlayer: AVAudioPlayer!=nil;
    var waitTime: Double!
    
    var randomNum: Double = Double(arc4random()) % 40
    
    @IBOutlet weak var bulbImageView: UIImageView!
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var tapMeLabel: UILabel!
    @IBOutlet var gameView: UIView!
    @IBOutlet var highScoreUpdatedLabel: UILabel!
    
    func playStartButtonAudio(){
        let path = NSBundle.mainBundle().pathForResource("start", ofType:"mp3");
        let url = NSURL(fileURLWithPath: path!);
        startButtonPlayer = AVAudioPlayer(contentsOfURL: url, error: nil);
        startButtonPlayer.prepareToPlay();
        startButtonPlayer.delegate = self
        startButtonPlayer.play();
        
    }

    func audioPlayerDidFinishPlaying(player: AVAudioPlayer!, successfully flag: Bool) {
        println("WE FINISHED PLAYING MUSIC")
        self.view.addSubview(self.gameView)
        self.startTime = NSDate().timeIntervalSince1970
        waitTime = (1.0 + randomNum) / 10
        waitTimer = NSTimer.scheduledTimerWithTimeInterval(waitTime,
            target: self,
            selector: Selector("waitTimerDidTick:"),
            userInfo: nil,
            repeats: false)
        
    }
        
    @IBAction func didStartGameTap(sender: AnyObject){
        playStartButtonAudio()
    }
    
    @IBAction func didStartMusicTap(sender: AnyObject){
        let musicView = LBMusicPlayerViewController(nibName: "MusicPlayerView", bundle: nil)
        self.navigationController?.pushViewController(musicView, animated: true)
    }
    
    func waitTimerDidTick(timer:NSTimer){
        bulbImageView.image = UIImage(named: "on.jpg")
        waitTimer.invalidate()
        waitTimer = nil
        countTimer = NSTimer.scheduledTimerWithTimeInterval(0.01,
            target: self,
            selector: Selector("countTimerDidTick:"),
            userInfo: nil,
            repeats: false)
    }
    
    func countTimerDidTick(timer:NSTimer){
        var score: NSTimeInterval = NSDate().timeIntervalSince1970 - self.startTime
        self.counterLabel.text = scoreTextWithScore(score)
    }
    
    func scoreTextWithScore(score:Double)->NSString{
        var toDisplay = NSString(format:"%02.0f:%02d:%02d", score/60, score%60, (score*100)%100)
        return toDisplay
    }
    
    func playTouchAudio(){
        let path = NSBundle.mainBundle().pathForResource("gun", ofType:"mp3");
        let url = NSURL(fileURLWithPath: path!);
        startButtonPlayer = AVAudioPlayer(contentsOfURL: url, error: nil);
        startButtonPlayer.prepareToPlay();
        startButtonPlayer.play();

    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        if(tapMeLabel.hidden == false){
            self.gameView.removeFromSuperview()
            self.tapMeLabel.hidden = true
            self.highScoreLabel.hidden = true
            self.highScoreUpdatedLabel.hidden = true
            self.counterLabel.text = "00:00:00"
            self.bulbImageView.image = UIImage(named: "off.jpg")
            return
        }
        
        if(self.countTimer == nil){
            return
        }
        
        var score: NSTimeInterval = NSDate().timeIntervalSince1970 - self.startTime
        self.counterLabel.text = scoreTextWithScore(score)
        
        self.countTimer.invalidate()
        self.countTimer = nil
        playTouchAudio()
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        var highScoreValue = userDefaults.doubleForKey("HighScore")
        if(highScoreValue == 0){
            highScoreValue = DBL_MAX
        }
        
        if(highScoreValue > score){
            self.highScoreUpdatedLabel.hidden = false
        }
        
        self.highScoreLabel.text = NSString(format: "High Score: %@", scoreTextWithScore(highScoreValue))
        self.highScoreLabel.hidden = false
        self.tapMeLabel.hidden = false
    }
}