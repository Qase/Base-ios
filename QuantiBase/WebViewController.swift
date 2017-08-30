//
//  WebViewController.swift
//  2N-mobile-communicator
//
//  Created by Jakub Prusa on 8/9/17.
//  Copyright © 2017 quanti. All rights reserved.
//

import UIKit
import QuantiLogger
import SnapKit

open class WebViewController: QBaseViewController {

    fileprivate var url: URL
    fileprivate let webView = UIWebView()

    public init(withURL url: URL){
        self.url = url
        super.init()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override open func viewDidLoad() {
        super.viewDidLoad()

        if isModal() {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(self.dissmiss))
        }


        webView.delegate = self

        view.addSubview(webView)

        webView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }

        webView.loadRequest(URLRequest(url: url))
    }

    func dissmiss() {
        self.dismiss(animated: true, completion: nil)
    }

    /// Override default implementation in case of HIPMC-631
    /// Potencional bugfix
    ///
    /// - Parameter animated:  should be animated?
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        webView.stopLoading()
        webView.delegate = nil
    }

    /// Override default implementation in case of HIPMC-631
    /// View should be automatically poped when user select something on tabbar
    ///
    /// - Parameter animated: should be animated?
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        navigationController?.popViewController(animated: animated)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.default
    }


}

extension WebViewController: UIWebViewDelegate {
    public func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        QLog("Webview fail with error \(error)", onLevel: .error)
    }

    public func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return true
    }

    public func webViewDidStartLoad(_ webView: UIWebView) {
        QLog("Webview started Loading", onLevel: .info)
    }

    public func webViewDidFinishLoad(_ webView: UIWebView) {
        QLog("Webview did finish load", onLevel: .info)
    }
    
}
