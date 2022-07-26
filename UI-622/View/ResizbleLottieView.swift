//
//  ResizbleLottieView.swift
//  UI-622
//
//  Created by nyannyan0328 on 2022/07/26.
//

import SwiftUI
import Lottie

struct ResizbleLottieView: UIViewRepresentable {
    
    let lottieName : String
    
    var onFinish : (AnimationView) -> ()
   
    func makeUIView(context: Context) -> UIView {
        
        let view = UIView()
        setUp(for: view)
        view.backgroundColor = .clear
        
        return view
        
    }
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
    func setUp(for to : UIView){
        
        let animationView = AnimationView(name: lottieName,bundle: .main)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.backgroundColor = .clear
        
        animationView.shouldRasterizeWhenIdle = true
        
        let contains = [
        
            animationView.widthAnchor.constraint(equalTo: to.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: to.heightAnchor),
        
        ]
        
        to.addSubview(animationView)
        to.addConstraints(contains)
        
        
        animationView.play{_ in
            
            onFinish(animationView)
        }
        
    }
}
