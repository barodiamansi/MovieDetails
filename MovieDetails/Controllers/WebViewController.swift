//
//  WebViewController.swift
//  MovieDetails
//
//  Created by Mansi Barodia on 9/9/18.
//  Copyright © 2018 Mansi Barodia. All rights reserved.
//

import UIKit
import WebKit

// Note: Even though WKWebView was introduced int iOS 8, there was a bug within it which wasn't resolved until iOS 11.
// Bug was around NSCoding because of which the app was always crashing on initWithCoder during runtime. To avoid app crash
// Apple prevented letting developers configure WKWebView within IB. It would present the error - "WKWebView NSCoding support was broken in previous versions" if you would try to do so.
class WebViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    var webView: WKWebView!
    var articleURL: URL?
    @IBOutlet var webViewContainer: UIView!
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureWebView()
        
        // Add webview delegates
        webView.uiDelegate = self
        webView.navigationDelegate = self
        self.loadURL()
    }
    
    private func configureWebView() {
        let webConfiguration = WKWebViewConfiguration()
        let customFrame = CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: 0.0, height: self.webViewContainer.frame.size.height))
        self.webView = WKWebView (frame: customFrame , configuration: webConfiguration)
        webView.translatesAutoresizingMaskIntoConstraints = false
        self.webViewContainer.addSubview(webView)
        webView.topAnchor.constraint(equalTo: webViewContainer.topAnchor).isActive = true
        webView.rightAnchor.constraint(equalTo: webViewContainer.rightAnchor).isActive = true
        webView.leftAnchor.constraint(equalTo: webViewContainer.leftAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: webViewContainer.bottomAnchor).isActive = true
        webView.heightAnchor.constraint(equalTo: webViewContainer.heightAnchor).isActive = true
    }
    
    private func loadURL() {
        guard let url = articleURL else {
            return
        }
        let myRequest = URLRequest(url: url)
        webView.load(myRequest)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        HUDManager.showHUD(show: true, view: self.view)
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        HUDManager.showHUD(show: false, view: self.view)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("Webview did fail load with error: \(error)")
        HUDManager.showHUD(show: false, view: self.view)
        
        let message: String = error.localizedDescription
        
        let loadFailText = NSLocalizedString("load failed", comment: "Web view failed to load text")
        let alert = UIAlertController(title: "\(loadFailText)", message: message, preferredStyle: .alert)
        let okText = NSLocalizedString("ok", comment: "Ok button text")
        alert.addAction(UIAlertAction(title: "\(okText)", style: .default) { action in
            // use action here
        })
        self.present(alert, animated: true)
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("Webview did fail to navigate: \(error)")
        HUDManager.showHUD(show: false, view: self.view)
        
        let message: String = error.localizedDescription
        
        let navigateFailText = NSLocalizedString("navigate failed", comment: "Web view failed to navigate text")
        let alert = UIAlertController(title: "\(navigateFailText)", message: message, preferredStyle: .alert)
        let okText = NSLocalizedString("ok", comment: "Ok button text")
        alert.addAction(UIAlertAction(title: "\(okText)", style: .default) { action in
            // use action here
        })
        self.present(alert, animated: true)
    }
}
