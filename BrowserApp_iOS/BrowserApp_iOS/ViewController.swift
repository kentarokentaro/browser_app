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

        // String
        let startURL = "https://www.google.co.jp"
        
        // NSURL
        if let url = NSURL(string: startURL) {

            // NSURLRequest
            let urlRequest = NSURLRequest(url: url as URL)
            
            // webView.loadRequest
            self.webView.loadRequest(urlRequest as URLRequest)
        }

        // 戻るボタン制御
        self.backButton.isEnabled = self.webView.canGoBack
        
        // 進むボタン制御
        self.forwardButton.isEnabled = self.webView.canGoForward
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // 戻るボタン
    @IBAction func goBack(_ sender: Any) {
        self.webView.goBack()
    }

    // 進むボタン
    @IBAction func goForward(_ sender: Any) {
        self.webView.goForward()
    }

    // リロードボタン
    @IBAction func reload(_ sender: Any) {
        self.webView.reload()
    }
}

