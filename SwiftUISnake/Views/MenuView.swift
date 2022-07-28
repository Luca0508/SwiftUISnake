//
//  MenuView.swift
//  SwiftUISnake
//
//  Created by CM0758 on 2022/7/26.
//

import SwiftUI

struct MenuView: View {
    
    
    var body: some View {
        Color.black.overlay {
       
            NavigationView {
                
                NavigationLink {
                    
                    SnakeView()
                    
                } label: {
                    
                    Text("Start Game !!!")
                        .bold()
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    
                }
            }
            
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
