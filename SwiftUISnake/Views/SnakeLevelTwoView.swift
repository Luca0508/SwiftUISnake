////
////  SnakeLevelTwoView.swift
////  SwiftUISnake
////
////  Created by CM0758 on 2022/7/27.
////
//
//import SwiftUI
//
//struct SnakeLevelTwoView: View {
//    
//    @StateObject private var viewModel = SnakeLevelTwoViewModel()
//    
//    @State var timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
//    
//    var body: some View {
//        ZStack {
//            Color.black.ignoresSafeArea()
//            
//            // ladybug
//            Image(systemName: "ladybug.fill")
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .frame(width: 17, height: 17, alignment: .center)
//                .foregroundColor(Color(red: 255/255 , green: 210/255 , blue: 0, opacity: 1))
//                .position(viewModel.ladyBugPosition)
//            
//            // snake
//            ForEach(0..<viewModel.snakePositionArray.count, id: \.self) { index in
//                Rectangle()
//                    .fill(Color.green)
//                    .frame(width: viewModel.snakeSize, height: viewModel.snakeSize, alignment: .center)
//                    .position(viewModel.snakePositionArray[index])
//            }
//            
//            if !viewModel.isAlive {
//                Text("Game Over!!!\nTry Again")
//                    .bold()
//                    .font(.largeTitle)
//                    .foregroundColor(.red)
//                    .onTapGesture {
//                        viewModel.startGame()
//                    }
//            }
//            
//        }.onAppear() {
//            viewModel.startGame()
//            
//        }
//        .onDisappear() {
//            viewModel.isAlive = false
//        }
//        .gesture(
//            DragGesture()
//                .onEnded({ gesture in
//                    viewModel.getDirection(gesture:gesture)
//                })
//        )
//        .onReceive(timer) { _ in
//            if viewModel.isAlive {
//                viewModel.changeDirection()
//                viewModel.changeBugDirection()
//                timer = Timer.publish(every: viewModel.snakeSpeed, on: .main, in: .common).autoconnect()
//                
//            }
//        }
//    
//    }
//    
//    
//
//    
//}
//
//struct SnakeLevelTwoView_Previews: PreviewProvider {
//    static var previews: some View {
//        SnakeLevelTwoView()
//    }
//}
