//
//  ViewController.swift
//  BrowserApp_iOS
//
//  Created by Kentaro Miura on 2017/02/13.
//  Copyright © 2017年 Kentaro Miura. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIWebViewDelegate {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var forwardButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // delegate
        self.webView.delegate = self
        
        // String
        let startURL = "https://www.google.co.jp"
        
        // NSURL
        if let url = NSURL(string: startURL) {

            // NSURLRequest
            let urlRequest = NSURLRequest(url: url as URL)
            
            // webView.loadRequest
            self.webView.loadRequest(urlRequest as URLRequest)
        }
        
        // ボタン制御メソッドの呼び出し
        self.setupButtonsEnabled()
        // 表示していない時は隠す
        self.activityIndicator.hidesWhenStopped = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    /// WebViewが表示開始時に呼び出される
    func webViewDidStartLoad(_ webView: UIWebView) {
        self.setupButtonsEnabled()
        self.activityIndicator.startAnimating()
    }
    
    /// WebViewが表示完了時に呼び出される
    func webViewDidFinishLoad(_ webView: UIWebView) {    
        self.setupButtonsEnabled()
        self.activityIndicator.stopAnimating()
        
        // URLテキスト
        if let urlString = self.webView.request?.url {
            self.textField.text = String(describing: urlString)
        }
    }

    /// ボタンの押下制御
    func setupButtonsEnabled() {
        // 戻るボタン制御
        self.backButton.isEnabled = self.webView.canGoBack
        // 進むボタン制御
        self.forwardButton.isEnabled = self.webView.canGoForward
    }
    
    
    /// 戻るボタン
    @IBAction func goBack(_ sender: Any) {
        self.webView.goBack()
    }

    /// 進むボタン
    @IBAction func goForward(_ sender: Any) {
        self.webView.goForward()
    }

    /// リロードボタン
    @IBAction func reload(_ sender: Any) {
        self.webView.reload()
    }
}

