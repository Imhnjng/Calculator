//
//  main.swift
//  baseballGame
//
//  Created by IMHYEONJEONG on 3/12/24.
//

import Foundation

// main.swift 파일
// 프로젝트 생성시 자동 생성됨

var scoreboard = [Int]()                                                            // [Int]() 이거 뭐야 makes a new empty array-of-Int instance.
var playing: Bool = true                                                            //q: 와일문에 바로 true 안적고 변수로 받은 이유?

while playing {
    //게임 시작시 문구
    print("----------------------------------------------")
    print("환영합니다! 원하시는 번호를 입력해주세요")
    print("1. 게임 시작하기  2. 게임 기록보기  3. 종료하기")
    
    guard let input = readLine() else { continue }                                  // readLine 이 옵셔널인건 알겠는데 아니면 컨티뉴?? 이해못함 컨티뉴면 다시 와일문 시작?
    
    //1. 게임 시작하기 2. 게임 기록보기 3. 종료하기 선택
    switch input {
        
    // 1. 게임 시작하기
    case "1":
        let game = BaseballGame()
        let tryCount = game.start() // BaseballGame 인스턴스를 만들고 start 함수를 구현하기
        print("tryCount : \(tryCount)")                                             //game.start 가 Int 로 받는건 알겠는데 이게 어케 tryCount 에 숫자로 담기지
        scoreboard.append(tryCount)                                                 // 게임 시도 할 때마다 시도 획수가 scoreboard 에 배열추가 scorebored는 숫자배열.
        
    // 2. 게임 기록보기
    case "2":
        print("점수보기")
        var index = 0
        for score in scoreboard {                                                   //??? ㅠㅠ scoreboard 배열 만큼
            index += 1
            print("\(index)번째 게임 : 시도 횟수 - \(score)")
        }
        break
    
    // 3. 종료하기
    case "3":
        print("게임을 종료합니다")
        playing = false                                                             // 게임을 종료해야하므로 while 문 false
        break
        
    //1,2,3 중 아무것도 선택하지 않고 다른 숫자나 문자를 입력했을 때
    default:
        print("올바른 숫자를 입력해주세요!")
        break
    }
    
}




//var numbers = (0...9).map { $0 }
//print("numbers : \(numbers)")
//let randomIndex = Int.random(in: Range(NSMakeRange(0, numbers.count))!)
//print("randomIndex : \(randomIndex)")
//let randomNumber = numbers[randomIndex]
//print("randomNumber : \(randomNumber)")



//var list = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
//print(list)
//
//list = list.map { x in
//    print(">> \(x)")
//    return x + 100
//}
//print(list)
//
//print("---------------클로저----------------")
//
//var newList = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
//newList = vanmap(newList, closure: { x in
//    print(">> \(x)")
//    return x + 100
//})
//print(newList)
//
//func vanmap(_ array: [Int], closure: (Int) -> Int) -> [Int] {
//    var resultList: [Int] = []
//    for x in array {
//        // x = 99
//        let userInput = closure(x)
//        resultList.append(userInput)
//    }
//    return resultList
//}
//print("-------------------------------")




//
// closure
//
//var age = 19
//print("-------------------------------")
//var closure1 = {                                                                  //func c() { print("Hello world") } 함수는 변수에 담을수 있음
//    print("hello world")
//}
//print(closure1)
//closure1()
//closure1()
//closure1()
//
//var closure2 = { () -> Int in
//    print("hello world2")
//    return 77
//}
//print(closure2)                                   // 출력: function
//print(closure2())                                 // 출력: hello world / 77
//
//var closure3 = { (x: String) -> String in
//    return "hello world3 \(x)"
//}
//print(closure3)                                   // 출력: function
//print(closure3("van"))                            // 출력: hello world3 van
//
//print("-------------------------------")
//
//func function1() -> Void {                        // Q: 파라미터에는 input 이 담기는 것?
//    print("hello world (function)")
//}
//print(function1)
//function1()                                       // 출력: hello world (function)
//
//func function2() -> Int {
//    print("hello world2 (function)")
//    return 177
//}
//print(function2)
//print(function2())
//
//func function3(_ x: String) -> String {
//    "hello world3 \(x)"
//}
//print(function3)
//print(function3("van"))
//
//
//func hjCalcuration(_ n1: Int, _ n2:Int, someOperation: (Int, Int) -> Int) -> Int {        // 기능을 만들기만 한것 아무일도 안일어남
//    return someOperation(n1, n2)
//}
//var result = hjCalcuration(10, 5) { x1, x2 in                                             // 입력 값을 넣고, 변수에 함수를 할당만 한 것. 아무일도 안일어남
//    x1 + x2 + 1000
//}
//print("result = \(result)")                 //변수 result를 호출-> 할당 된 함수 호출-> 함수hj에 입력값 넣어줌
//print("-------------------------------")





//var result = (0...9).map { $0 }
//print("result : \(result)")
//result = result.shuffled()
//print("result : \(result)")
//
//var count = 0
//result = result.filter { x in                         //Q: 해석 못함
//    if count < 3 && (count == 0 && x != 0) {
//        count += 1
//        return true
//    }
//    return false
//}
//print("result : \(result)")



//struct Person {
//    var name: String
//    var age: Int
//}
//
//let persons = [Person(name: "van", age: 40), nil, Person(name: "hj", age: 26)]
//let personNames = persons.map { x in x?.name }
//let personNamesCompact = persons.compactMap { x in x?.name }
//let personAges = persons.map { x in x?.age }
//
////let names: [String] = ["van", "aaaa"]
////var result = names.map { x in
////    print(">> \(x)")
////    return "hey"
////}
//
//print("persons: \(persons)")
//print("personNames: \(personNames)")
//print("personNamesCompact: \(personNamesCompact)")
//print("personAges: \(personAges)")
//
//
//print()
//print()
//var personNames2: [String?] = []
//for person in persons {
//    personNames2.append(person?.name)
//}
//print("personNames2: \(personNames2)")
