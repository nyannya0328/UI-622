//
//  Home.swift
//  UI-622
//
//  Created by nyannyan0328 on 2022/07/26.
//

import SwiftUI

struct Home: View {
    @State var showContent : Bool = false
    @State var showLootie : Bool = false
    @State var expandCard : Bool = false
    
    @Namespace var animation
    var body: some View {
        VStack{
            
            HStack{
                
                HStack{
                    
                    Image(systemName: "applelogo")
                        .font(.system(size:40))
                    
                    Text("Pay")
                        .font(.largeTitle)
                }
                .foregroundColor(.white)
                
                Spacer()
                
                
                Button {
                    
                } label: {
                    
                    Text("Back")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }

            }
            
            cardView()
            
            
            
            Text("Woohoo!")
                .font(.largeTitle.weight(.heavy))
            
            
            Text("When you send or receive money with someone, you each earn a scratch card that can contain amazing prices !!")
                .kerning(1.02)
                .multilineTextAlignment(.center)
                .padding(.vertical)
            
            
            Button {
                
            } label: {
                
                Text("New Balance".uppercased())
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .frame(maxWidth: .infinity,alignment: .center)
                    .background{
                     
                        Rectangle()
                            .fill(.linearGradient(colors: [Color("Purple"),Color("Purple1")], startPoint: .leading, endPoint: .trailing))
                    }
                
                    
            }
            .padding(.top,15)

            
            
            
            
            
            
        }
        .padding(15)
        .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .top)
        .background{
         
            Color("BG").ignoresSafeArea()
        }
        .overlay(content: {

            Rectangle()
                .fill(.ultraThinMaterial)
               
                .opacity(showContent ? 1 : 0)
                .ignoresSafeArea()

        })
        .overlay(content: {
            
            
            GeometryReader{proxy in
                
                 let size = proxy.size
                
                if expandCard{
                    
                    ScrachCardView(size: size)
                        .overlay{
                            
                            
                            if showLootie{
                                
                                ResizbleLottieView(lottieName: "Party") { view in
                                    
                                    
                                    withAnimation(.easeInOut){
                                        
                                        showLootie = false
                                    }
                                }
                                .scaleEffect(3)
                                .clipShape(RoundedRectangle(cornerRadius: 10,style: .continuous))
                            }
                            
                            
                            
                        }
                        .matchedGeometryEffect(id: "GIFTCRD", in: animation)
                        .transition(.asymmetric(insertion: .identity, removal: .offset(x:1)))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .onAppear{
                            
                            withAnimation(.easeInOut(duration: 0.35)){
                                
                                showContent = true
                                showLootie = true
                            }
                        }
                        
                }
                
            
            }
            .padding(30)


        })
        .overlay(alignment:.topTrailing, content: {
            
            
            Button {
                
                withAnimation(.easeInOut(duration: 0.5)){
                    
                    showContent = false
                    showLootie = false
                }
                
                withAnimation(.easeInOut(duration: 0.35).delay(0.1)){
                    
                    expandCard = false
                }
                
            } label: {
                
                 Image(systemName: "xmark")
                    .font(.title3)
                    .foregroundColor(.white)
                    .padding(15)
                    .background{
                     
                        Circle()
                            .fill(.ultraThinMaterial)
                    }
            }
            .opacity(showContent ? 1 : 0)

            
            
        })
        .preferredColorScheme(.dark)
      
    }
    
    @ViewBuilder
    func cardView()->some View{
        
        GeometryReader{proxy in
            
            let size = proxy.size
            
            
            ScratchCardView(pointSize: 60) {
                
                if !expandCard{
                    
                    ScrachCardView(size: size)
                        .matchedGeometryEffect(id: "TABAA", in: animation)
                }
                
               
                
            } overlay: {
                
                Image("Card")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.width * 0.9,height: size.width * 0.9,alignment: .topLeading)
                    .clipShape(RoundedRectangle(cornerRadius: 10,style: .continuous))
                
            } onFinish: {
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                    
                    
                    withAnimation(.interactiveSpring(response: 0.6,dampingFraction: 0.7,blendDuration: 0.7)){
                        
                        expandCard = true
                    }
                }
                
            }
            .frame(width: size.width,height: size.height)

            
            
            
        }
        .padding(15)
        
        
    }
    
    @ViewBuilder
    func ScrachCardView(size : CGSize)->some View{
        
        VStack(spacing:16){
            
            Image("Trophy")
                .resizable()
                .aspectRatio(contentMode: .fit)
                 .frame(width: 150,height: 150)
            
            
            Text("You on")
                .font(.title3.weight(.semibold))
                .foregroundColor(.gray.opacity(0.3))
            
            
            
            HStack{
                
                Image(systemName: "applelogo")
                Text("$59")
            }
            .font(.title)
            .foregroundColor(.black)
            
            Text("It will be credited within 24 hours")
                .font(.caption)
                .foregroundColor(.gray)
            
        }
        .padding(20)
        .frame(maxWidth: size.width * 0.9, maxHeight: size.width * 0.9)
        .background{
         
            RoundedRectangle(cornerRadius: 10,style: .continuous)
                .fill(.white)
        }
        
        
    }

    
    
    

   
    
   
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
