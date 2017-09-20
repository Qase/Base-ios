//
//  WebViewController.swift
//  2N-mobile-communicator
//
//  Created by Jakub Prusa on 8/9/17.
//  Copyright © 2017 quanti. All rights reserved.
//

import UIKit

open class WebViewController: QBaseViewController {

    fileprivate var url: URL
    fileprivate let webView = UIWebView()
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)

    public init(withURL url: URL){
        self.url = url
        super.init()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override open func viewDidLoad() {
        super.viewDidLoad()

        if isModal {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(self.dissmiss))
        }


        webView.delegate = self

        view.addSubview(webView)

        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        webView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        webView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: webView.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: webView.centerYAnchor).isActive = true

        activityIndicator.startAnimating()
        webView.loadRequest(URLRequest(url: url))
    }

    @objc func dissmiss() {
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

}

extension WebViewController: UIWebViewDelegate {
    public func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print("Webview fail with error \(error)")
    }

    public func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return true
    }

    public func webViewDidStartLoad(_ webView: UIWebView) {
        print("Webview started Loading: \(String(describing: webView.request))")
    }

    public func webViewDidFinishLoad(_ webView: UIWebView) {
        print("Webview did finish load: \(String(describing: webView.request))")
        activityIndicator.stopAnimating()
    }
    
}
