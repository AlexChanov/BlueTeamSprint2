//
//  AuthorizationVC.swift
//  AppStructure
//
//  Created by VadimQw  on 14/11/2019.
//  Copyright © 2019 Ikhtiyor Nurmatov. All rights reserved.
//

import UIKit
import WebKit

public final class AuthorizationVC: UIViewController, WKNavigationDelegate {
    
    private var webView: WKWebView!

    override public func loadView() {
        super.loadView()
        webView = WKWebView(frame: .zero, configuration: WKWebViewConfiguration())
        view = webView
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        let closeButton = UIButton.close()
        closeButton.addTarget(self, action: #selector(closeButtonHit), for: .touchUpInside)
        view.addSubview(closeButton)
        closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 45).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        //
        webView.navigationDelegate = self
        webView.load(TrelloRequestManager.shared.authorization())
    }

    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript("document.documentElement.outerHTML.toString()") { (html, error) in
            guard let html = html as? String else { return }
            let range = NSRange(location: 0, length: html.count)
            let regex = try! NSRegularExpression(pattern: "<pre>[a-z0-9]{64}</pre>")
            let match = regex.firstMatch(in: html, options: [], range: range)
            
            guard let _match = match else { return }
            let tokenStr = String(html[Range(_match.range, in: html)!])
            let tokenRange = Range(NSRange(location: 5, length: 64), in: tokenStr)
            let token = String(tokenStr.substring(with: tokenRange!))
            UserDefaults.standard.setTrelloToken(token)
            AppDelegate.shared.rootViewController.switchToMainScreen()
            self.closeButtonHit()
        }
    }

    // MARK: - Buttons
    @objc private func closeButtonHit() {
        dismiss(animated: true, completion: nil)
    }
}
