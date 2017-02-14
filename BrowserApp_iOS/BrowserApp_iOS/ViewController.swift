//
//  ViewController.swift
//  BrowserApp_iOS
//
//  Created by Kentaro Miura on 2017/02/13.
//  Copyright © 2017年 Kentaro Miura. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var forwardButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func goBack(_ sender: Any) {
    }

    @IBAction func goForward(_ sender: Any) {
    }

    @IBAction func reload(_ sender: Any) {
    }
}

