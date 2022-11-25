//
//  Orders.swift
//  NC1
//
//  Created by Sofia Esposito on 24/11/22.
//

import SwiftUI

struct Orders: View {
    var body: some View {
        NavigationView{
            VStack{
                Image("sticker-2")
                    .resizable()
                    .frame(width:200, height: 200)
                Text("STOP TO BUY THINGS!")
                    .fontWeight(.bold)
                    .foregroundColor(Color.red)
                    .foregroundColor(Color.red)
                
            }
        }.navigationTitle("Orders")
    }
}

struct Orders_Previews: PreviewProvider {
    static var previews: some View {
        Orders()
    }
}
