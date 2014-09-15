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
    weak var countTImer: NSTimer!
    var startTime: NSTimeInterval!

    var startButtonPlayer: AVAudioPlayer!=nil;
    
    @IBOutlet weak var bulbImageView: UIImageView!
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var tapMeLabel: UILabel!
    @IBOutlet var gameView: UIView!
    
    
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
    }
        
    @IBAction func didStartGameTap(sender: AnyObject){
        playStartButtonAudio()
    }
    
    @IBAction func didStartMusicTap(sender: AnyObject){
        
        
    }
    
    
    
    
}