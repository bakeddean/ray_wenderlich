//
//  ViewController.swift
//  CircleTransition
//
//  Created by Dean Woodward on 20/01/16.
//  Copyright © 2016 Datacom. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func circleTapped(sender: UIButton) {
        navigationController?.popViewControllerAnimated(true)
    }


}

