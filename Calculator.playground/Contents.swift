
//덧셈
class AddOperation {
    func add(_ number1: Double, _ number2: Double) -> Double {
        return number1 + number2
    }
}

//뺼셈
class SubstractOperation {
    func substract(_ number1: Double, _ number2: Double) -> Double {
        return number1 - number2
    }
}

//곱셈
class MultiplyOperation {
    func multiply(_ number1: Double, _ number2: Double) -> Double {
        return number1 * number2
    }
}

//나눗셈
class DivideOperation {
    func divide(_ number1: Double, _ number2: Double) -> Double {
        return number1 / number2
    }
}


class Calculator {
    
    //프로퍼티 초기화
    let addOperation: AddOperation
    let substractOperation: SubstractOperation
    let multiplyOperation: MultiplyOperation
    let divideOperation: DivideOperation
    
    init(add: AddOperation,
         substract: SubstractOperation,
         multiply: MultiplyOperation,
         divide: DivideOperation) {
        self.addOperation = add
        self.substractOperation = substract
        self.multiplyOperation = multiply
        self.divideOperation = divide
    }
    
    // 더하기
    func add(_ number1: Double, _ number2: Double) -> Double {
        return addOperation.add(number1, number2)
    }

    
    // 빼기
    func substract(_ number1: Double, _ number2: Double) -> Double {
        return substractOperation.substract(number1, number2)
    }
    
    // 곱하기
    func multiply(_ number1: Double, _ number2: Double) -> Double {
        return multiplyOperation.multiply(number1, number2)
    }
    
    // 나누기
    func divide(_ number1: Double, _ number2: Double) -> Double {
        return divideOperation.divide(number1, number2)
    }
    
    // 나머지 연산
    func remind(_ number1: Double, _ number2: Double) -> Int {
        return Int(number1) % Int(number2)
    }
}
    

let calculate = Calculator(add: AddOperation(), substract: SubstractOperation(), multiply: MultiplyOperation(), divide: DivideOperation())

let addResult = calculate.add(1, 2)// 덧셈 연산
let subtractResult = calculate.substract(3, 4)// 뺄셈 연산
let multiplyResult = calculate.multiply(5, 6)// 곱셈 연산
let divideResult = calculate.divide(7, 8)// 나눗셈 연산
let remindResult = calculate.remind(9, 1)//나머지 연산

print("addResult : \(addResult)")
print("subtractResult : \(subtractResult)")
print("multiplyResult : \(multiplyResult)")
print("divideResult : \(divideResult)")
print("remindResult : \(remindResult)")
