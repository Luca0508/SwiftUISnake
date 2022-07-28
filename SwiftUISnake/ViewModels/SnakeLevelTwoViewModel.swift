//
//  SnakeLevelTwoViewModel.swift
//  SwiftUISnake
//
//  Created by CM0758 on 2022/7/27.
//

import SwiftUI

class SnakeLevelTwoViewModel: GameBaseViewModel {
    

    override func changeBugDirection() {
        let dist = getDistanceBetweenBugAndSnake()
        
        let bugDirection = getDirectForBug()

        if dist < 25 {
            
            switch bugDirection {
            case .up:
                ladyBugPosition.y -= snakeSize
            case .down:
                ladyBugPosition.y += snakeSize
            case .right:
                ladyBugPosition.x += snakeSize
            case .left:
                ladyBugPosition.x -= snakeSize
            }
        }
    }
    
    
    private func getDistanceBetweenBugAndSnake() -> Double {
        
        let ladyBugX = Double(ladyBugPosition.x)
        let ladyBugY = Double(ladyBugPosition.y)
        
        let snakePosition = snakePositionArray[0]
        let snakeX = Double(snakePosition.x)
        let snakeY = Double(snakePosition.y)
        
        let distance = sqrt(Double(pow((ladyBugX - snakeX), 2) + pow((ladyBugY - snakeY), 2)))
        return distance
    }
    
    private func getDirectForBug() -> Direction {
        let snakePosition = snakePositionArray[0]
        
        let isLadyBugXSmaller = ladyBugPosition.x < snakePosition.x
        let isLadyBugYSmaller = ladyBugPosition.y < snakePosition.y
        
        let isHittingMinX = ladyBugPosition.x <= minX + snakeSize
        let isHittingMaxX = ladyBugPosition.x >= maxX - snakeSize
        let isHittingMinY = ladyBugPosition.y <= minY + snakeSize
        let isHittingMaxY = ladyBugPosition.y >= maxY - snakeSize
          
        if isHittingMinX && isHittingMinY {
            if snakeDirection == .up {
                return .right
            } else if snakeDirection == .left {
                return .down
            }
        } else if isHittingMaxX && isHittingMinY {
            if snakeDirection == .up {
                return .left
            } else if snakeDirection == .right {
                return .down
            }
        } else if isHittingMinX && isHittingMaxY {
            if snakeDirection == .down {
                return .right
            } else if snakeDirection == .left {
                return .up
            }
        } else if isHittingMaxX && isHittingMaxY {
            if snakeDirection == .down {
                return .left
            } else if snakeDirection == .right {
                return .up
            }
        }
        
        
        if isHittingMinX || isHittingMaxX {
            if isLadyBugYSmaller {
                return .up
            }
            return .down

        } else if isHittingMinY || isHittingMaxY {
            if isLadyBugXSmaller {
                return .left
            }
            return .right
        }
        
        
        return Direction.allCases.filter { direction in
            direction != snakeDirection
        }.randomElement()!
        
//        let distX = abs(ladyBugPosition.x - snakePosition.x)
//        let distY = abs(ladyBugPosition.y - snakePosition.y)
//
//        if distX < distY {
//            if isLadyBugXSmaller {
//                return .left
//            }
//            return .right
//        }
//
//        if isLadyBugYSmaller{
//            return .up
//        }
//        return.down
    }
    

}
