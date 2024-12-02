//
//  ScrollController.swift
//  Finder
//
//  Created by dgsw07 on 10/29/24.
//

import SwiftUI

struct CustomScrollView<Content: View>: UIViewRepresentable {
    var content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    func makeUIView(context: Context) -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }

    func updateUIView(_ uiView: UIScrollView, context: Context) {
        let host = UIHostingController(rootView: content)
        host.view.frame = CGRect(x: 0, y: 0, width: uiView.frame.width, height: uiView.frame.height)
        uiView.addSubview(host.view)
        uiView.contentSize = host.view.intrinsicContentSize 
    }
}


