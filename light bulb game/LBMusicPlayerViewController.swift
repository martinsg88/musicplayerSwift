//
//  File.swift
//  light bulb game
//
//  Created by Guilherme Martins on 9/17/14.
//  Copyright (c) 2014 com.gui.kenshuSwift. All rights reserved.
//

import Foundation
import UIkit
import AVFoundation

class LBMusicPlayerViewController : UIViewController, AVAudioPlayerDelegate{
    
    var musicOnePlayer: AVAudioPlayer!
    var musicTwoPlayer: AVAudioPlayer!
    var effectPlayer: AVAudioPlayer!
    
    
    func playMusicOneButtonTap(){
        let path = NSBundle.mainBundle().pathForResource("music", ofType:"mp3");
        let url = NSURL(fileURLWithPath: path!);
        musicOnePlayer = AVAudioPlayer(contentsOfURL: url, error: nil);
        musicOnePlayer.prepareToPlay();
        musicOnePlayer.delegate = self
        musicOnePlayer.play();

    }
    
    func playMusicTwoButtonTap(){
        let path = NSBundle.mainBundle().pathForResource("gun", ofType:"mp3");
        let url = NSURL(fileURLWithPath: path!);
        musicTwoPlayer = AVAudioPlayer(contentsOfURL: url, error: nil);
        musicTwoPlayer.prepareToPlay();
        musicTwoPlayer.delegate = self
        musicTwoPlayer.play();
    }
    
    func playEffectButtonTap(){
        let path = NSBundle.mainBundle().pathForResource("snare", ofType:"mp3");
        let url = NSURL(fileURLWithPath: path!);
        effectPlayer = AVAudioPlayer(contentsOfURL: url, error: nil);
        effectPlayer.prepareToPlay();
        effectPlayer.delegate = self
        effectPlayer.play();
   
    }
    
    @IBAction func playReturnButtonTap(sender: AnyObject){
        self.navigationController?.popViewControllerAnimated(false)
    }
    
    @IBAction func didEffectButtonTap(sender: AnyObject){
        
    }
    
    @IBAction func didMusicTwoButtonTap(sender: AnyObject){
        
    }
    
    @IBAction func didMusicOneButtonTap(sender: AnyObject){
        
    }
    
    
}

