//
//  LobbyViewController.swift
//  TechMon
//
//  Created by 三昌拓海 on 2021/11/14.
//

import UIKit

class LobbyViewController: UIViewController {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var staminaLabel: UILabel!
    let techMonManager = TechMonManager.shared
    var stamina: Int = 100
    var staminaTimer: Timer!

    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = "勇者"
        staminaLabel.text = "\(stamina)/100"
        staminaTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.updateStaminaValue), userInfo: nil, repeats: true)
        staminaTimer.fire()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        techMonManager.playBGM(fileName: "lobby")
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        techMonManager.stopBGM()
    }
    @IBAction func toBattle(){
        if stamina > 50{
            stamina -= 50
            staminaLabel.text = "\(stamina)/100"
            performSegue(withIdentifier: "toBattle", sender: nil)
        }else{
            let alert: UIAlertController = UIAlertController(title: "バトルにいけません", message: "スタミナをためてください", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    @objc func updateStaminaValue(){
        if stamina < 100 {
            stamina += 1
            staminaLabel.text = "\(stamina)/100"
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
