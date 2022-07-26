//
//  ScratchCardView.swift
//  UI-622
//
//  Created by nyannyan0328 on 2022/07/26.
//

import SwiftUI

struct ScratchCardView<Content : View,overLay : View>: View {
    
    var content : Content
    var overlay : overLay
    var pointSize : CGFloat
    var onFinish : ()->()
    
    init(pointSize: CGFloat,@ViewBuilder  content: @escaping()->Content,@ViewBuilder overlay:@escaping()->overLay,  onFinish: @escaping () -> Void) {
        self.content = content()
        self.overlay = overlay()
        self.pointSize = pointSize
        self.onFinish = onFinish
    }
    
    @State var isScratched : Bool = false
    @State var disableGesture : Bool = false
    @State var dragPoints : [CGPoint] = []
    @State var animatedCard : [Bool] = [false,false]
    var body: some View {
        GeometryReader{proxy in
            
             let size = proxy.size
            
            ZStack{
                
                overlay
                
                content
                    .mask {
                        
                        if disableGesture{
                            
                            Rectangle()
                        }
                        else{
                            PointShape(points: dragPoints)
                                .stroke(style: StrokeStyle(lineWidth: isScratched ? (size.width * 1.4) : pointSize,lineCap: .round,lineJoin: .round))
                            
                        }
                    }
                
            }
            .gesture(
            
            
                DragGesture(minimumDistance: disableGesture ? 100000 : 0)
                    .onChanged{value in
                        if dragPoints.isEmpty{
                            
                            
                            withAnimation(.easeInOut){
                                
                                animatedCard[0] = false
                                animatedCard[1] = false
                                
                                
                            }
                            
                            
                        }
                        
                        dragPoints.append(value.location)
                        
                        
                        
                    }
                    .onEnded{value in
                        
                        
                        if !dragPoints.isEmpty{
                            
                            
                            withAnimation(.linear(duration: 0.6)){
                                
                                isScratched = true
                                
                            }
                            
                            onFinish()
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.35){
                                
                                
                                disableGesture = true
                            }
                        }
                        
                        
                    }
            
            
            
            
            )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .rotation3DEffect(.init(degrees: animatedCard[0] ? 5 : 0), axis: (x: 1, y: 0, z: 0))
        .rotation3DEffect(.init(degrees: animatedCard[1] ? 5 : 0), axis: (x: 0, y: 1, z: 0))
        .onAppear{
            
            
            DispatchQueue.main.async {
                
                withAnimation(.easeIn(duration: 1).repeatForever(autoreverses: true)){
                    
                    animatedCard[0] = true
                }
                
                withAnimation(.easeInOut(duration: 1).delay(1).repeatForever(autoreverses: true)){
                    
                    animatedCard[1] = true
                }
                
            }
          
        }
    }
}

struct ScratchCardView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct PointShape : Shape{
    
    var points : [CGPoint]
    
    var animatableData: [CGPoint]{
        
        get{points}
        set{points = newValue}
        
    }
    
    func path(in rect: CGRect) -> Path {
        Path{path in
            
            
            if let first = points.first{
                
                path.move(to: first)
                path.addLines(points)
            }
            
            
        }
    }
}
