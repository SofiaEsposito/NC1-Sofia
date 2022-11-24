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
    
    // MARK: Detail View Properties
    @State var currentCard: Card?
    @State var showDetailCard: Bool = false
    @Namespace var animation
    
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
                        NavigationLink{ Orders() }
                    label: { Image(systemName:"shippingbox.circle.fill")}
                    }
                    if expandCards{
                        EmptyView()
                    } else {
                        NavigationLink{ AddToWallet() }
                    label: {Image(systemName: "plus.circle.fill")}
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
                            // If you want Pure transition without this little opacity change in the sense just remove this if..else condition
                            Group{
                                if currentCard?.id == card.id && showDetailCard{
                                    CardView(card: card )
                                        .opacity(0)
                                } else {
                                     CardView(card: card)
                                         .matchedGeometryEffect(id: card.id, in: animation)
                                }
                            }

                                .onTapGesture {
                                    withAnimation(
                                        .easeInOut(duration:0.35)) {
                                            currentCard = card
                                            showDetailCard = true
                                            
                                        }
                                }
                            
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
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay{
                if let currentCard = currentCard, showDetailCard {
                    DetailView(currentCard: currentCard, showDetailCard: $showDetailCard, animation: animation)
                      
                }
                
            }
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
    }
// MARK: Hiding all Number except last four
// Global Method
func customisedCardNumber(number: String)->String {
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

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

 // MARK: Detail View

struct DetailView : View{
    var currentCard: Card
    @Binding var showDetailCard: Bool
    // Matched Geometry  Effect
    var animation: Namespace.ID
    
    // Delaying Expanses View
    
    @State var showExpenseView = false
   
    
    var body: some View {
        
        VStack{
            CardView()
                .matchedGeometryEffect(id: currentCard.id, in: animation)
                .frame(height: 200)
                .onTapGesture {
                // Closings Expensive View First
                    withAnimation(.easeInOut) {
                        showExpenseView = false
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2 ){
                        withAnimation(.easeInOut(duration: 0.35)){
                            showDetailCard = false
                            
                        }
                    }
                }
                .zIndex(10)
            

                    GeometryReader { proxy in
                        
                        let height = proxy.size.height +  50
                        
                        ScrollView(.vertical, showsIndicators: false){
                            VStack(spacing: 20){
                                
                                 // Expenses
                                ForEach(expenses){ expense in
                                    // Card View
                                    ExpenseCardView(expense: expense)
                                    
                                }
                            }
                            .padding()
                        }
                        .frame(maxWidth: .infinity)
                        .background(
                            Color.white
                                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                                .ignoresSafeArea()
                        )
                        .offset(y: showExpenseView ? 0 : height)
                        
                    }
                    .padding([.horizontal, .top])
                    .zIndex(-10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top )
        .background(Color.white.ignoresSafeArea())
        .onAppear{
            withAnimation(.easeInOut.delay(0.1)) {
                
                showExpenseView = true
            }
        }
    }
    @ViewBuilder
    func  CardView()-> some View{
        
        ZStack(alignment: .bottomLeading) {
            Image(currentCard.cardImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            // Card Details
            
            VStack(alignment: .leading, spacing: 10){
                Text(currentCard.name)
                    .fontWeight(.bold)
                
                Text(customisedCardNumber(number: currentCard.cardNumber))
                    .font(.callout)
                    .fontWeight(.bold)
            } // chiusura VStack 3
            .padding()
            .padding(.bottom,10)
            .foregroundColor(.white)
            
        } // chiusura ZStack1
        
    }
}

struct ExpenseCardView: View {
    
    var expense: Expense
    
    // Displaying Expenses one by one Based on Index
    @State var showView = false
    @State var presentSophie = false
    
    var body: some View {
        
        HStack(spacing:14){
            Image(expense.productIcon)
                .resizable()
                .aspectRatio(contentMode: .fit )
                .frame(width: 45, height: 45)
            
            VStack(alignment: .leading, spacing: 8){
                 
                Text(expense.product)
                    .fontWeight(.bold)
                 
                Text(expense.spendType)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment:  .leading)
            
            VStack(spacing: 8){
                Text(expense.amountSpent)
                    .fontWeight(.bold)
                 
                Text(Date().formatted(date: .numeric, time: .omitted))
                    .font(.caption)
                    .foregroundColor(.gray)
                
            }
            .popover(isPresented: $presentSophie) {
                VStack{
                    Image("sticker")
                        .resizable()
                        .frame(width:200, height: 200)
                    Text("You spend too much money!!")
                        .fontWeight(.bold)
                        .foregroundColor(Color.red)
                        .foregroundColor(Color.red)
                }
            }
            
        }
        .onTapGesture {
           presentSophie = true
        }
        
        
        
        }
    }


