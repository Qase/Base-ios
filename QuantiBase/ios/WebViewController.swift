//
//  WebViewController.swift
//  2N-mobile-communicator
//
//  Created by Jakub Prusa on 8/9/17.
//  Copyright © 2017 quanti. All rights reserved.
//

import UIKit
import WebKit

open class WebViewController: UIViewController {
    fileprivate var url: URL
    fileprivate let webView = WKWebView()
	let activityIndicator = UIActivityIndicatorView(style: .gray)

    public init(withURL url: URL) {
        self.url = url

        super.init(nibName: nil, bundle: nil)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override open func viewDidLoad() {
        super.viewDidLoad()

        webView.navigationDelegate = self
//            .delegate = self

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
        webView.load(URLRequest(url: url))
    }

    /// Override default implementation in case of HIPMC-631
    /// Potencional bugfix
    ///
    /// - Parameter animated:  should be animated?
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        webView.stopLoading()
    }

    /// Override default implementation in case of HIPMC-631
    /// View should be automatically poped when user select something on tabbar
    ///
    /// - Parameter animated: should be animated?
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
}

extension WebViewController: WKNavigationDelegate {
    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("Webview fail with error \(error)")
    }

    public func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("Webview fail with error \(error)")
    }

    public func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("Webview did finish load: \(String(describing: webView.url))")
        activityIndicator.stopAnimating()
    }

    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Webview started Loading: \(String(describing: webView.url))")
    }
}
