//
//  ViewController.swift
//  BrowserApp_iOS
//
//  Created by Kentaro Miura on 2017/02/13.
//  Copyright © 2017年 Kentaro Miura. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIWebViewDelegate,UITextFieldDelegate {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var forwardButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // delegate
        self.webView.delegate = self
        self.textField.delegate = self
        
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

    
// MARK: WEBVIEW
    
    /// ネットワークエラー時
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        self.webView.stopLoading()
        self.activityIndicator.stopAnimating()
        
        // ネットワークキャンセル時
        if error.code != NSURLErrorCancelled() {
            self.showAlert(message: "Network Error!")
        }
        
        
        self.updateLocation()
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
    
    ///
    func updateLocation() {
        if let urlString = self.webView.request?.url?.absoluteString {
            self.textField.text = String(describing: urlString)
        }
    }
    
// MARK: TEXTFIELD
    
    /// テキストフィールドに入力した際に呼ばれる
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        var urlString = self.textField.text
        // 前後の空白を取り除く
        urlString = urlString?.trimmingCharacters(in: NSCharacterSet.whitespaces)
        
        if urlString == "" {
            // alert
            self.showAlert(message: "Please Enter URL")
        }
        else {
            self.jumpToURL(urlString: urlString!)
            self.setupButtonsEnabled()
        }
        
        // フォーカスを外す（キーボードを隠す）
        self.textField.resignFirstResponder()

        return true
    }
   
    /// テキストフィールド検索した際の遷移
    func jumpToURL(urlString: String) {
        
        if let url = NSURL(string: urlString) {
            let urlRequest = NSURLRequest(url: url as URL)
            self.webView.loadRequest(urlRequest as URLRequest)
        }
        else {
            self.showAlert(message: "Invalid URL")
        }
    }
    
    /// テキストフィールド検索した際のアラート表示
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK",style: .default, handler: nil)
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }
   
// MARK: BUTTON

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

