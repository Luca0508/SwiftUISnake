//
//  SnakeLevelTwoViewModel.swift
//  SwiftUISnake
//
//  Created by CM0758 on 2022/7/27.
//

import SwiftUI

class SnakeLevelTwoViewModel: ObservableObject {
    
    @Published var snakePositionArray: [CGPoint] = [CGPoint(x: 20, y: 20)]
    @Published var ladyBugPosition: CGPoint = CGPoint(x: 120, y: 120)
    @Published var snakeDirection: Direction = .down
    @Published var isAlive: Bool = true
    @Published var snakeSpeed: Double = 0.2
    
    let snakeSize: CGFloat
    let minX: CGFloat
    let maxX: CGFloat
    let minY: CGFloat
    let maxY: CGFloat
    
    var ladyBugDirection: Direction?
    
    init() {
        self.snakeSize = 15
        minX = UIScreen.main.bounds.minX + snakeSize
        minY = UIScreen.main.bounds.minY + snakeSize
        
        let originMaxX = UIScreen.main.bounds.maxX - snakeSize
        maxX = SnakeViewModel.getCorrectBound(maxBound: originMaxX, snakeSize: snakeSize)
        let originMaxY = UIScreen.main.bounds.maxY - 50
        maxY = SnakeViewModel.getCorrectBound(maxBound: originMaxY, snakeSize: snakeSize)
        
        print("max x \(maxX) max y \(maxY)")
    }
    
    // 原本的 max x max y 無法被 蛇的方塊大小整除
    class func getCorrectBound(maxBound: CGFloat, snakeSize: CGFloat) -> CGFloat {
        var maxBoundInt = Int(maxBound)
        let remainder = maxBoundInt % Int(snakeSize)
        maxBoundInt -= remainder
        return CGFloat(maxBoundInt)
    }
    
    private func getRandomPosition() -> CGPoint {
    
        let rows = Int(maxY / snakeSize)
        let columns = Int(maxX / snakeSize)

        let randomX = Int.random(in: 1..<columns - 1)  * Int(snakeSize)
        let randomY = Int.random(in: 1..<rows - 1)  * Int(snakeSize)
        
        return CGPoint(x: randomX, y: randomY)
    }
    
    func changeDirection(){
        var prevSnakePosition = snakePositionArray[0]
        
        switch snakeDirection {
        case .up:
            snakePositionArray[0].y -= snakeSize
        case .down:
            snakePositionArray[0].y += snakeSize
        case .right:
            snakePositionArray[0].x += snakeSize
        case .left:
            snakePositionArray[0].x -= snakeSize
        }
        
        if snakePositionArray[0].x < minX {
            snakePositionArray[0].x = maxX
            
        } else if snakePositionArray[0].x > maxX {
            snakePositionArray[0].x = minX
            
        } else if snakePositionArray[0].y < minY {
            snakePositionArray[0].y = maxY
            
        } else if snakePositionArray[0].y > maxY {
            snakePositionArray[0].y = minY
        }
        
        for index in 1..<snakePositionArray.count {
            let oldSnakePosition = snakePositionArray[index]
            snakePositionArray[index] = prevSnakePosition
            prevSnakePosition = oldSnakePosition
        }
        
        doesSnakeKillItself(newPosition: snakePositionArray[0])
        hasBugBeenKilled()
    }
    
    func getDirection(gesture: DragGesture.Value) {
        let xDist = abs(gesture.startLocation.x - gesture.location.x)
        let yDist = abs(gesture.startLocation.y - gesture.location.y)
        
        let prevDirection = snakeDirection
        var newDirection: Direction? = nil
        
        if gesture.startLocation.y > gesture.location.y && yDist > xDist {
            newDirection = .up
        } else if gesture.startLocation.y < gesture.location.y && yDist > xDist {
            newDirection = .down
        } else if gesture.startLocation.x < gesture.location.x && yDist < xDist {
            newDirection = .right
        } else if gesture.startLocation.x > gesture.location.x && yDist < xDist {
            newDirection = .left
        }
        
        guard let newDirection = newDirection else {
            return
        }

        if (prevDirection == .up && newDirection == .down) ||
            (prevDirection == .down && newDirection == .up) ||
            (prevDirection == .left && newDirection == .right) ||
            (prevDirection == .right && newDirection == .left) {
            return
        }
        
        snakeDirection = newDirection
        
    }
    
    func startGame() {
        isAlive = true
        snakePositionArray[0] = getRandomPosition()
        ladyBugPosition = getRandomPosition()
    }
    
    func changeBugDirection() {
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
        
        
        print("bug \(bugDirection) \(ladyBugPosition) snake \(snakePositionArray[0])")
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
    
    private func hasBugBeenKilled() {
        if snakePositionArray[0] == ladyBugPosition {
            ladyBugPosition = getRandomPosition()
            snakePositionArray.append(snakePositionArray[0])
            
            if snakeSpeed >= 0.04 {
                snakeSpeed -= 0.02
            }
        }
    }
    
    private func doesSnakeKillItself(newPosition: CGPoint) {
        if snakePositionArray[1..<snakePositionArray.count].contains(newPosition) {
            isAlive = false
        }
    }
}
