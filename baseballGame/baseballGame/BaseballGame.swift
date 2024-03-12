//
//  BaseballGame.swift
//  baseballGame
//
//  Created by IMHYEONJEONG on 3/12/24.
//

import Foundation

// BaseballGame.swift 파일 생성
class BaseballGame {
    //정답은 랜덤으로 만듭니다.(1에서 9까지의 서로 다른 임의의 수 3자리)
    func start() {
        print("start")
        let answer = makeAnswer() // 정답을 만드는 함수
    }
    
    func makeAnswer() -> Int {
        // 함수 내부를 구현하기
        while true {
            let firstNum = Int.random(in: 1...9)
            let secondNum = Int.random(in: 1...9)
            let thirdNum = Int.random(in: 1...9)
            
            if firstNum == secondNum || secondNum == thirdNum || thirdNum == firstNum {
                //숫자 중복시
                print("같은 숫자 존재", firstNum, secondNum, thirdNum)
            } else {
                //모두 다른 숫자
                print("모두 다른 숫자", firstNum, secondNum, thirdNum)
                break
            }
            let result = Int(String(firstNum) + String(secondNum) + String(thirdNum))
        }
        return answer
    }
}

//let randomNum = Int.random(in: 111...999)
//print(randomNum)

//print("random num \(Int.random(in: 111...999))")
//Expressions are not allowed at the top level

/*
Lv2
class 혹은 struct {
    func start() {
        let answer = makeAnswer() // 정답을 만드는 함수
        
        while true {
            // 1. 유저에게 입력값을 받음
            
            // 2. 정수로 변환되지 않는 경우 반복문 처음으로 돌아가기
            
            // 3. 세자리가 아니거나, 0을 가지거나 특정 숫자가 두번 사용된 경우 반복문 처음으로 돌아가기
            
            // 4. 정답과 유저의 입력값을 비교하여 스트라이크/볼을 출력하기
            // 만약 정답이라면 break 호출하여 반복문 탈출
        }
    }
}

*/
