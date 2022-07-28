//
//  SwiftUISnakeApp.swift
//  SwiftUISnake
//
//  Created by CM0758 on 2022/7/26.
//

import SwiftUI

@main
struct SwiftUISnakeApp: App {

    @StateObject var viewModel: GameBaseViewModel = getRandomGameLevel()
    
    var body: some Scene {
        WindowGroup {
            SnakeView().environmentObject(viewModel)
        }
    }
    
    static func getRandomGameLevel() -> GameBaseViewModel {
        return switchViewModel(type: Gamelevel.allCases.randomElement()!)
    }
    
    static func switchViewModel(type: Gamelevel) -> GameBaseViewModel {
        switch type {
        case .levelOne:
             return SnakeViewModel()
        case .levelTwo:
            return SnakeLevelTwoViewModel()
        }
    }
}
