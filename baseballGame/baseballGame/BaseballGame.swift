//
//  BaseballGame.swift
//  baseballGame
//
//  Created by IMHYEONJEONG on 3/16/24.
//

import Foundation

class BaseballGame {
    var title: String?
    
    func start() {
        let answer = makeAnswer() // 정답을 만드는 함수
        //print("[ answer \(answer) ]")
        
        print("< 게임을 시작합니다 >")

        while true {
            // 1. 유저에게 입력값을 받음
            print("숫자를 입력하세요")
            guard let input = readLine() else { continue }
            
            // 2. 정수로 변환되지 않는 경우 반복문 처음으로 돌아가기
            guard let inputNumber = Int(input) else {
                print("올바르지 않은 입력값입니다 (숫자가 아님)")
                continue
            }

            // 3. 세자리가 아니거나, 0을 가지거나 특정 숫자가 두번 사용된 경우 반복문 처음으로 돌아가기
            if input.count != 3 {
                print("올바르지 않은 입력값입니다 (자릿수 틀림)")
                continue
            }
            else if input.contains("0") {
                print("올바르지 않은 입력값입니다 (0은 사용못함)")
                continue
            }
            
            let s1 = input[input.index(input.startIndex, offsetBy: 0)]
            let s2 = input[input.index(input.startIndex, offsetBy: 1)]
            let s3 = input[input.index(input.startIndex, offsetBy: 2)]
            if s1 == s2 || s2 == s3 || s3 == s1 {
                print("올바르지 않은 입력값입니다 (숫자 중복)")
                continue
            }

            // 4. 정답과 유저의 입력값을 비교하여 스트라이크/볼을 출력하기
            // 만약 정답이라면 break 호출하여 반복문 탈출
            if answer == inputNumber {
                print("정답입니다!")
                break
            }
            else {
                let answerStr = String(answer)
                let a1 = answerStr[answerStr.index(answerStr.startIndex, offsetBy: 0)]
                let a2 = answerStr[answerStr.index(answerStr.startIndex, offsetBy: 1)]
                let a3 = answerStr[answerStr.index(answerStr.startIndex, offsetBy: 2)]
                
                var strikeCount = 0
                var ballCount = 0
                
                if a1 == s1 {
                    strikeCount += 1
                }
                else if s1 == a2 || s1 == a3 {
                    ballCount += 1
                }
                
                if a2 == s2 {
                    strikeCount += 1
                }
                else if s2 == a1 || s2 == a3 {
                    ballCount += 1
                }
                
                if a3 == s3 {
                    strikeCount += 1
                }
                else if s3 == a1 || s3 == a2 {
                    ballCount += 1
                }
        //        print("[ strikeCount \(strikeCount) ]")
        //        print("[ ballCount \(ballCount) ]")
                
                if strikeCount == 0 && ballCount == 0 {
                    print("Nothing")
                }
                else if strikeCount != 0 && ballCount != 0 {
                    print("\(strikeCount)스트라이크 \(ballCount)볼")
                }
                else if strikeCount != 0 {
                    print("\(strikeCount)스트라이크")
                }
                else if ballCount != 0 {
                    print("\(ballCount)볼")
                }
            }
        }
    }
    
    func makeAnswer() -> Int {
        var n1: Int = 0
        var n2: Int = 0
        var n3: Int = 0
        while true {
            n1 = Int.random(in: 1...9)
            n2 = Int.random(in: 1...9)
            n3 = Int.random(in: 1...9)
    //        print("\(n1)\(n2)\(n3)")

            if n1 == n2 || n2 == n3 || n3 == n1 {
                print("wrong answer \(n1)\(n2)\(n3)")
            }
            else {
                break
            }
        }
        return n1 * 100 + n2 * 10 + n3
    }
}


