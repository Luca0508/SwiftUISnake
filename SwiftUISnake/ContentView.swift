//
//  ContentView.swift
//  SwiftUISnake
//
//  Created by CM0758 on 2022/7/26.
//

import SwiftUI

struct ContentView: View {
    
    //@State
    //@Binding
    @StateObject var viewModel: MyViewModel = MyViewModel()
    
    var body: some View {
        Color.gray
            .overlay {
                VStack {
                    Text("Hello, world!")
                        .padding()
                    
                    Button {
                        viewModel.model.number += 1
                        
                    } label: {
                        Text("\(viewModel.model.number)")
                    }
                    .frame(width: 100, height: 100, alignment: .center)
                    .background(Color.pink)
                    
                    GreenView()
                        .environmentObject(viewModel)
                    
                }
                .background(Color.gray)
                .onAppear {
                    
                }
                .onDisappear {
                    
                }
            }
        
    }
    
}


struct GreenView: View {
    
    @EnvironmentObject var viewModel: MyViewModel
    
    var body: some View {
        Color.green
            .overlay {
                Text("internal number: \(viewModel.model.number)")
            }
    }
}


class MyViewModel: ObservableObject {
    @Published var model: MyModel = MyModel()
}

// struct 搭配 Published 才能夠有 binding 效果
struct MyModel {
    var number = 0
    var name = "Mary"
}






struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portraitUpsideDown)
    }
}
