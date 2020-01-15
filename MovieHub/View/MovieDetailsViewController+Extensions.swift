//
//  MovieDetailsViewController+Extensions.swift
//  MovieHub
//
//  Created by Leialey on 14.01.2020.
//  Copyright © 2020 Ekaterina Rodionova. All rights reserved.
//

import WebKit

extension MovieDetailsViewController: WKUIDelegate, WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        isAnimating = false
    }
}

extension MovieDetailsViewController: MovieDetailsView {
    func showStatus(_ statusMessage: String?) {
        DispatchQueue.main.async {
            self.navigationItem.title = statusMessage
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.navigationItem.title = nil
        }
    }
    
    func reloadData() {
        guard let videoURL = presenter?.getMovie().videoURL else { fatalError("URL empty")}
        playerView.load(URLRequest(url: videoURL))
    }
}
