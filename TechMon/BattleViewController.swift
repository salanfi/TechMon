//
//  BattleViewController.swift
//  TechMon
//
//  Created by 三昌拓海 on 2021/11/14.
//

import UIKit

class BattleViewController: UIViewController {
    @IBOutlet var playerNameLabel: UILabel!
    @IBOutlet var playerImageVIew: UIImageView!
    @IBOutlet var playerHPLabel: UILabel!
    @IBOutlet var playerMPLabel: UILabel!
    @IBOutlet var playerTPLabel: UILabel!
    @IBOutlet var enemyNameLabel: UILabel!
    @IBOutlet var enemyImageView: UIImageView!
    @IBOutlet var enemyHPLabel: UILabel!
    @IBOutlet var enemyMPLabel: UILabel!
    let techMonManager = TechMonManager.shared
    var playerHP = 100
    var playerMP = 0
    var enemyHP = 200
    var enemyMP = 0
    var player: Character!
    var enemy: Character!
    var gameTimer: Timer!
    var isPlayerAttackAvailabel: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        player = techMonManager.player
        enemy = techMonManager.enemy
        playerNameLabel.text = "勇者"
        playerImageVIew.image = UIImage(named: "yusya.png")
        playerHPLabel.text = "\(playerHP)/100"
        playerMPLabel.text = "\(playerMP)/20"
        enemyNameLabel.text = "龍"
        enemyImageView.image = UIImage(named: "monster.png")
        enemyHPLabel.text = "\(enemyHP)/200"
        enemyMPLabel.text = "\(enemyMP)/35"
        gameTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateGame), userInfo: nil, repeats: true)
        gameTimer.fire()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        techMonManager.playBGM(fileName: "BGM_battle001")
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        techMonManager.stopBGM()
        techMonManager.resetStatus()
    }
    @objc func updateGame(){
        playerMP += 1
        if playerMP >= 20{
            isPlayerAttackAvailabel = true
            playerMP = 20
        }else{
            isPlayerAttackAvailabel = false
        }
        enemyMP += 1
        if enemyMP >= 35{
            enemyAttack()
            enemyMP = 0
        }
        playerMPLabel.text = "\(playerMP)/20"
        enemyMPLabel.text = "\(enemyMP)/35"
    }
    func enemyAttack(){
        techMonManager.damageAnimation(imageView: playerImageVIew)
        techMonManager.playSE(fileName: "SE_attack")
        playerHP -= 20
        playerHPLabel.text = "\(playerHP)/100"
        if playerHP <= 0 {
            finishBattle(vanishImageView: playerImageVIew, isplayerwin: false)
        }
    }
    
    func finishBattle(vanishImageView: UIImageView, isplayerwin: Bool){
        techMonManager.stopBGM()
        gameTimer.invalidate()
        isPlayerAttackAvailabel = false
        var finishMessage: String = ""
        if isplayerwin{
            techMonManager.playSE(fileName: "SE_fanfare")
            finishMessage = "勇者の勝利！"
        }else{
            techMonManager.playSE(fileName: "SE_gameover")
            finishMessage = "勇者の敗北..."
        }
        
        let alert = UIAlertController(title: "バトル終了", message: finishMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in self.dismiss(animated: true, completion: nil)}))
        present(alert, animated: true, completion: nil)
    }
    @IBAction func attackAction(){
        if isPlayerAttackAvailabel{
            techMonManager.damageAnimation(imageView: enemyImageView)
            techMonManager.playSE(fileName: "SE_attack")
            enemyHP -= 30
            playerMP = 0
            enemyHPLabel.text = "\(enemyHP)/200"
            playerMPLabel.text = "\(playerMP)/20"
            if enemyHP <= 0{
                finishBattle(vanishImageView: enemyImageView, isplayerwin: true)
            }
            player.currentTP += 10
            if player.currentTP >= player.maxTP{
                player.currentTP = player.maxTP
            }
        }
    }
    func updateUI(){
        playerHPLabel.text = "\(player.currentHP)/\(player.maxHP)"
        playerMPLabel.text = "\(player.currentMP)/\(player.maxMP)"
        playerTPLabel.text = "\(player.currentTP)/\(player.maxTP)"
        enemyHPLabel.text = "\(enemy.currentHP)/\(enemy.maxHP)"
        enemyMPLabel.text = "\(enemy.currentMP)/\(enemy.maxMP)"
    }
    func judgeBattle(){
        if player.currentHP <= 0{
            finishBattle(vanishImageView: playerImageVIew, isplayerwin: false)
        }else if enemy.currentHP <= 0{
            finishBattle(vanishImageView: enemyImageView, isplayerwin: true)
        }
    }
    @IBAction func tameruAction(){
        if isPlayerAttackAvailabel{
            techMonManager.playSE(fileName: "SE_charge")
            player.currentTP += 40
            if player.currentTP >= player.maxTP{
                player.currentTP = player.maxTP
            }
            player.currentMP = 0
        }
    }
    @IBAction func fireAction(){
        if isPlayerAttackAvailabel && player.currentTP >= 40{
            techMonManager.damageAnimation(imageView: enemyImageView)
            techMonManager.playSE(fileName: "SE_fire")
            enemy.currentHP -= 100
            player.currentTP -= 40
            if player.currentTP <= 0{
                player.currentTP = 0
            }
            player.currentMP = 0
            judgeBattle()
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
