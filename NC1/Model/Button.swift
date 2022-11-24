//
//  Button.swift
//  NC1
//
//  Created by Sofia Esposito on 23/11/22.
//

import SwiftUI

struct NavButton: View {
    var name: String
    var destination = AddToWallet()
    
    var body: some View {
        
       
        Button { destination
        }
    label: { Image(systemName: name)
            .foregroundColor(.black)
    }
    }
}


