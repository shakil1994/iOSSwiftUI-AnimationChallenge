//
//  Home.swift
//  AnimationChallenge
//
//  Created by Md Shah Alam on 4/3/22.
//

import SwiftUI

struct Home: View {
    
    // MARK: Animated View Properties
    @State var currentIndex: Int = 0
    @State var currentTab: String = "Bags"
    
    // MARK: Detail View Properties
    @State var detailBag: Bag?
    @State var showDetailView: Bool = false
    
    // FOR MATCHED GEOMETRY EFFECT STORING CURRENT CARD SIZE
    @State var currentCardSize: CGSize = .zero
    
    //Environment Values
    @Namespace var animation
    @Environment(\.colorScheme) var schema
    
    var body: some View {
        ZStack {
            // BG
            BGView()
            
            // MARK: Main View Content
            VStack{
                
                // Custom Nav Bar
                NabBar()
                
                SnapCarousel(spacing: 20, trailingSpace: 110, index: $currentIndex, items: bags){ bags in
                    
                    GeometryReader { proxy in
                        let size = proxy.size
                        
                        Image(bags.artwork)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: size.width, height: size.height)
                            .cornerRadius(15)
                            .matchedGeometryEffect(id: bags.id, in: animation)
                            .onTapGesture {
                                currentCardSize = size
                                detailBag = bags
                                withAnimation(.easeInOut){
                                    showDetailView = true
                                }
                            }
                        
                    }
                }
                
                // Since Carousel is Moved The Current card a little bit up
                // Using Padding to Avoid the Undercovering the top element
                .padding(.top, 70)
                
                //Custom Indicator
                CustomIndicator()
                
                HStack {
                    Text("Popular")
                        .font(.title3.bold())
                    
                    Spacer()
                    
                    Button("See More"){}
                    .font(.system(size: 16, weight: .semibold))
                }
                .padding()
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15){
                        ForEach(bags) {bag in
                            Image(bag.artwork)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 120)
                                .cornerRadius(15)
                        }
                    }
                    .padding()
                }
            }
            .overlay {
                if let bag = detailBag, showDetailView {
                    DetailView(bag: bag, showDetailView: $showDetailView, detailBag: $detailBag, currentCardSize: $currentCardSize, animation: animation)
                }
            }
        }
    }
    
    // MARK: Custom Indicator
    @ViewBuilder
    func CustomIndicator() -> some View {
        HStack (spacing: 5){
            ForEach(bags.indices, id: \.self){ index in
                Circle()
                    .fill(currentIndex == index ? .blue : .gray.opacity(0.5))
                    .frame(width: currentIndex == index ? 10 : 6, height: currentIndex == index ? 10 : 6)
            }
        }
        .animation(.easeInOut, value: currentIndex)
    }
    
    // MARK: Custom Nav Bar
    @ViewBuilder
    func NabBar() -> some View {
        HStack(spacing: 0) {
            ForEach(["Bags", "Localities"], id: \.self) { tab in
                Button{
                    withAnimation{
                        currentTab = tab
                    }
                }
            label: {
                Text(tab)
                    .foregroundColor(.white)
                    .padding(.vertical, 6)
                    .padding(.horizontal, 20)
                    .background{
                        if currentTab == tab {
                            Capsule()
                                .fill(.regularMaterial)
                                .environment(\.colorScheme, .dark)
                                .matchedGeometryEffect(id: "TAB", in: animation)
                        }
                    }
            }
                
            }
        }
        .padding()
    }
    
    // MARK: Blurred BG
    @ViewBuilder
    func BGView() -> some View {
        GeometryReader{ proxy in
            let size = proxy.size
            
            TabView(selection: $currentIndex){
                ForEach(bags.indices, id: \.self){ index in
                    Image(bags[index].artwork)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                        .clipped()
                        .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .animation(.easeInOut, value: currentIndex)
            
            let color: Color = (schema == .dark ? .black : .white)
            // Custom Gradient
            LinearGradient(colors: [
                .black,
                .clear,
                color.opacity(0.15),
                color.opacity(0.5),
                color.opacity(0.8),
                color,
                color
            ], startPoint: .top, endPoint: .bottom)
            
            // Blurred Overlay
            Rectangle().fill(.ultraThinMaterial)
        }
        .ignoresSafeArea()
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home().preferredColorScheme(.dark)
    }
}
