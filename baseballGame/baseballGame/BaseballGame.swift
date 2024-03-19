//
//  BaseballGame.swift
//  baseballGame
//
//  Created by IMHYEONJEONG on 3/16/24.
//

import Foundation

class BaseballGame {                                                //재사용을 위한 class 만들기
    var title: String?                                              // ??
    
    func start() -> Int {                                           // 게임시작 함수./ 기능만 만들뿐 아무것도 안하는 상태
        let answer = makeAnswer() // 정답을 만드는 함수                 // 상수에 정답 만드는 함수 담기 이름()--> 이게 함수표시. 변수상수에 함수 담기 가능
        print("[ answer \(answer) ]")                               // 답 출력하는 코드.
        
        print("< 게임을 시작합니다 >")                                  // 게임시작 문구
        
        var tryCount = 0                                            // 시도 횟수

        while true {                                                //while 문: 참일 동안 계속 실행
            // 1. 유저에게 입력값을 받음
            print("숫자를 입력하세요")
            guard let input = readLine() else { continue }              // Q: main.파일에 있는 readLine 이랑 다른것?
            
            // 2. 정수로 변환되지 않는 경우 반복문 처음으로 돌아가기
            guard let inputNumber = Int(input) else {                   // ??
                print("올바르지 않은 입력값입니다 (숫자가 아님)")
                continue
            }
            let inputNumbers = input.compactMap { Int(String($0)) }     // compactMap??
            print("inputNumbers \(inputNumbers)")
            
            // 3. 세자리가 아니거나, 0을 가지거나 특정 숫자가 두번 사용된 경우 반복문 처음으로 돌아가기
            
            // 세자리가 아니거나
            if inputNumbers.count != 3 {
                print("올바르지 않은 입력값입니다 (자릿수 틀림)")
                continue
            }
            // 0을 가지거나
            else if inputNumbers[0] == 0 {
                print("올바르지 않은 입력값입니다 (첫번째 자리에 0 사용못함)")
                continue
            }
            
//            let s1 = input[input.index(input.startIndex, offsetBy: 0)]
//            let s2 = input[input.index(input.startIndex, offsetBy: 1)]
//            let s3 = input[input.index(input.startIndex, offsetBy: 2)]
            
            //특정 숫자가 두번 사용된 경우
            if inputNumbers[0] == inputNumbers[1] || inputNumbers[1] == inputNumbers[2] || inputNumbers[2] == inputNumbers[0] {
                print("올바르지 않은 입력값입니다 (숫자 중복)")
                continue
            }

            // 4. 정답과 유저의 입력값을 비교하여 스트라이크/볼을 출력하기
            // 만약 정답이라면 break 호출하여 반복문 탈출
            var strikeCount = 0
            var ballCount = 0
            
            // 첫번째 숫자가 같을 경우 1스트라이크 증가
            if answer[0] == inputNumbers[0] {
                strikeCount += 1
            }
            // 입력한 숫자 첫번째가 정답 숫자 2,3번째 숫자와 같을 때 볼 카운트 1 증가
            else if answer[1] == inputNumbers[0] || answer[2] == inputNumbers[0] {
                ballCount += 1
            }
            
            // 두번째 숫자가 같을 경우 1스트라이크 증가
            if answer[1] == inputNumbers[1] {
                strikeCount += 1
            }
            // 입력한 숫자의 두번쨰 숫자가 정답 숫자 2,3 번째랑 같을 떄 볼 카운트 1 증가
            else if answer[0] == inputNumbers[1] || answer[2] == inputNumbers[1] {
                ballCount += 1
            }
            
            // 세번째 숫자가 같을 때 1스트라이크 증가
            if answer[2] == inputNumbers[2] {
                strikeCount += 1
            }
            // 입력한 숫자의 세번째 숫자가 정답 숫자 2,3 번째랑 같을 때 볼 카운트 1 증가
            else if answer[0] == inputNumbers[2] || answer[1] == inputNumbers[2] {
                ballCount += 1
            }
    //        print("[ strikeCount \(strikeCount) ]")
    //        print("[ ballCount \(ballCount) ]")
            
            //시도 횟수 1씩 증가
            tryCount += 1                               // tryCount = tryCount + 1
            
            //
            if strikeCount == 3 {                       // 가장 범위가 좁은 확률? 가장 상위에
                print("정답입니다")
                return tryCount                         // 정답을 맞추면 시도횟수 같이 보여줌
            }
            // 아무숫자도 맞지 않으면 nothing
            else if strikeCount == 0 && ballCount == 0 {
                print("Nothing")
            }
            // 스트라이크나 볼이 '둘 다' 하나라도 있으면 숫자 출력
            else if strikeCount != 0 && ballCount != 0 {
                print("\(strikeCount)스트라이크 \(ballCount)볼")
            }
            // 스트라이크가 하나 이상 일 때
            else if strikeCount != 0 {
                print("\(strikeCount)스트라이크")
            }
            //볼이 하나 이상 일 때
            else if ballCount != 0 {
                print("\(ballCount)볼")
            }
        }
    }
    
    func makeAnswer() -> [Int] {
        let numbers = (0...9).map { $0 }                    // ??클로저,, map 다시 공부
        return randomNumbers(numbers, 3)                    // ramdomNumbers 에 인풋으로 numbers 배열 넣고 count 3 리턴
        
        // lv1
//        var n1: Int = 0
//        var n2: Int = 0
//        var n3: Int = 0
//        while true {
//            n1 = Int.random(in: 1...9)
//            n2 = Int.random(in: 1...9)
//            n3 = Int.random(in: 1...9)
//    //        print("\(n1)\(n2)\(n3)")
//
//            if n1 == n2 || n2 == n3 || n3 == n1 {
//                print("wrong answer \(n1)\(n2)\(n3)")
//            }
//            else {
//                break
//            }
//        }
////        return n1 * 100 + n2 * 10 + n3
//        return [n1, n2, n3]
    }
    
    func randomNumbers(_ array: [Int], _ count: Int) -> [Int] {
        guard array.count > count else { return [] }                 // array 배열 갯수가 count(3임) 그니까 3보다 작으면 빈배열 리턴 --?Q: 그럴일이 있나
        
        var array = array
        var elements: [Int] = []
        while elements.count < count {
            // pick
            if let pickElement = array.randomElement(), let pickIndex = array.firstIndex(of: pickElement) {
    //            print("pickNumber : \(pickElement)")
    //            print("pickIndex : \(pickIndex)")
                
                // if 0 index가 0이면 재추첨. 처음으로 뽑은 숫자가 0이면 재추첨
                if elements.count == 0 && pickElement == 0 {
                    print("0인덱스에 0이 나와서 재추첨")
                    continue
                }
                
                // 뽑기
                array.remove(at: pickIndex)
                
                // 뽑기 결과 리스트에 추가
                elements.append(pickElement)
            }
        }
        return elements
    }
}


