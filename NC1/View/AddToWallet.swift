//
//  AddToWallet.swift
//  NC1
//
//  Created by Sofia Esposito on 24/11/22.
//

import SwiftUI

struct AddToWallet: View {
    var body: some View {
        NavigationView{
            VStack{
                Image("sticker1")
                    .resizable()
                    .frame(width:200, height: 200)
                Text("You don't have money anymore")
                    .fontWeight(.bold)
                    .foregroundColor(Color.red)
                    .foregroundColor(Color.red)
            }
            
        } .navigationTitle("Add to Wallet")
    }
}

struct AddToWallet_Previews: PreviewProvider {
    static var previews: some View {
        AddToWallet()
    }
}
