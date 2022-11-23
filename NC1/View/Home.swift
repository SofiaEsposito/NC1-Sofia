//
//  Home.swift
//  NC1
//
//  Created by Sofia Esposito on 23/11/22.
//

import SwiftUI

struct Home: View {
    // MARK: Animation Properties
    @State var expandCards: Bool = false
    var body: some View {
        NavigationView(){
            VStack (spacing:0){
                HStack {
                    Text(expandCards ? "": "Wallet")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .overlay(alignment: .leading){
                            // MARK: Close Button
                            Button {
                                // Closing Cards
                                withAnimation(.interactiveSpring(response: 0.8, dampingFraction: 0.7, blendDuration: 0.7)) {
                                    expandCards = false
                                } // chiusura Animation
                            } label: {
                                Text("Done")
                                    .padding(10)
                                    .fontWeight(.semibold)
                            }
                            .rotationEffect(.init(degrees: expandCards ? 0 :  0))
                            .offset(x: expandCards ? 10 : 15 )
                            .opacity(expandCards ? 1 : 0)
                            
                        } // chiusura overlay2
                        .padding(.horizontal,15)
                        .padding(.bottom,10)
                    
                    Spacer()
                    
                    if expandCards{ EmptyView()
                    } else {
                        NavButton(name: "shippingbox.circle.fill")
                    }
                    if expandCards{
                        EmptyView()
                    } else {
                        NavButton(name: "plus.circle.fill")
                    }
                    if expandCards{
                        NavButton(name: "ellipsis.circle.fill")
                    } else {
                        EmptyView()
                    }
                
                } // chiusura HStack1
                ScrollView(.vertical, showsIndicators: false){
                    
                    VStack(spacing:0){
                        // MARK: Cards
                        
                        ForEach(cards){ card in
                            CardView(card: card)
                            
                        } // chiusura ForEach1
                    } // chiusura  VStack 2
                    .overlay{
                        // To Avoid Scrolling
                        Rectangle()
                            .fill(.black.opacity(expandCards ? 0 : 0.001))
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.35)) {
                                    expandCards = true
                                    
                                    
                                } // chiusura withAnimation1
                            } // chiusura TapGesture1
                        
                            .padding(.top, expandCards ? 30 : 0)
                        
                    } // chiusura overlay1
                    
                } // chiusura ScrollView
                .coordinateSpace(name: "SCROLL")
                .offset(y: expandCards ? 0 : 30)
                
                
            } // chiusura VStack 1
        } // chiusura Navigation View
            .padding([.horizontal, .top])
        }
        // MARK: Card View
        @ViewBuilder
        func CardView(card: Card )-> some View{
            GeometryReader{ proxy in
                
                let rect = proxy.frame(in: .named("SCROLL"))
                //  Let's display some Portion of each Card
                let offset = CGFloat(getIndex(Card: card) * ( expandCards ? 10 : 70))
                
                ZStack(alignment: .bottomLeading) {
                    Image(card.cardImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                    // Card Details
                    
                    VStack(alignment: .leading, spacing: 10){
                        Text(card.name)
                            .fontWeight(.bold)
                        
                        Text(customisedCardNumber(number: card.cardNumber))
                            .font(.callout)
                            .fontWeight(.bold)
                    } // chiusura VStack 3
                    .padding()
                    .padding(.bottom,10)
                    .foregroundColor(.white)
                    
                } // chiusura ZStack1
                // Making  it as a Stack
                .offset(y: expandCards ? offset : -rect.minY + offset)
                
            } // chiusura GeometryReader 1
            // Max size
            .frame(height: 200)
            
        } // chiusura CardView
        // Retriving Index
        func getIndex(Card: Card)-> Int{
            return cards.firstIndex { currentCard in
                return currentCard.id == Card.id
            } ?? 0 // chiusura return index
        } // chiusura getIndex
        // MARK: Hiding all Number except last four
        
        func customisedCardNumber(number: String)->String{
            var newValue: String = " "
            let maxCount = number.count - 4
            
            number.enumerated().forEach { value in
                if value.offset >=  maxCount {
                    // Displaying Text
                    
                    let string = String(value.element)
                    newValue.append(contentsOf: string)
                    
                } // chiusura if1
                else {
                    // Simply Displaying Star
                    // Avoiding  Space
                    let string = String(value.element)
                    if string == " " {
                        newValue.append(contentsOf: " ")
                    } // chiusura if2
                    else {
                    } // chiusura else2
                    newValue.append(contentsOf: "*")
                    
                } // chiusura else1
            } // chiusura ForEach2
            
            return newValue
            
        } // chiusura func customisedCardNumber
    }
struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

