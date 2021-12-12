//
//  MapViewController.swift
//  TechMon
//
//  Created by 三昌拓海 on 2021/12/12.
//

import UIKit

class MapViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func toSlime(){
        performSegue(withIdentifier: "tobattle", sender: "1")
    }
    @IBAction func toSckelton(){
        performSegue(withIdentifier: "tobattle", sender: "2")
    }
    @IBAction func toDoragon(){
        performSegue(withIdentifier: "tobattle", sender: "#")
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let vc = segue.destination as? BattleViewController {
                vc.stageID = sender as! String
            }
        }
    @IBAction func back(){
        dismiss(animated: true, completion: nil)
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
