class AbstractOperation {
    func operate(_ number1: Double, _ number2: Double) -> Double {
        print("AbstractOperation operate")
        return 0
    }
}


//덧셈
class AddOperation: AbstractOperation {
    override func operate(_ number1: Double, _ number2: Double) -> Double {
        print("AddOperation operate")
        print("AddOperation operate super값이 궁금해 \(super.operate(number1, number2))")
        return number1 + number2
    }
}

//뺼셈
class SubstractOperation: AbstractOperation {
    override func operate(_ number1: Double, _ number2: Double) -> Double {
        number1 - number2
    }
}

//곱셈
class MultiplyOperation: AbstractOperation {
    override func operate(_ number1: Double, _ number2: Double) -> Double {
        number1 * number2
    }
}

//나눗셈
class DivideOperation: AbstractOperation {
    override func operate(_ number1: Double, _ number2: Double) -> Double {
        number1 / number2
    }
}

class ExtendDivideOperation: DivideOperation {
    override func operate(_ number1: Double, _ number2: Double) -> Double {
        guard number2 != 0 else { return 0.0 }
        return super.operate(number1, number2)
    }
}

class RemindOperation: AbstractOperation {
    override func operate(_ number1: Double, _ number2: Double) -> Double {
        number1.truncatingRemainder(dividingBy: number2)
    }
}



class Calculator {
    
    enum OperatorType {
        case add
        case substract
        case multiply
        case divide
        case remind
    }
    
    //프로퍼티 초기화
    private let addOperation: AbstractOperation
    private let substractOperation: AbstractOperation
    private let multiplyOperation: AbstractOperation
    private let divideOperation: AbstractOperation
    private let remindOperation: AbstractOperation
    
    init(addOp: AbstractOperation,
         substractOp: AbstractOperation,
         multiplyOp: AbstractOperation,
         divideOp: AbstractOperation,
         remindOp: AbstractOperation) {
        print("init")
        self.addOperation = addOp // AddOperation instance
        self.substractOperation = substractOp
        self.multiplyOperation = multiplyOp
        self.divideOperation = divideOp
        self.remindOperation = remindOp
        
        //self.addOperation.operate(1, 2) // mem: AddOperation
        //(self.addOperation as! AddOperation).superAdd()
    }
    
    // 더하기
    func add(_ number1: Double, _ number2: Double) -> Double {
        print("add func")
        return addOperation.operate(number1, number2)
    }
    
    // 빼기
    func substract(_ number1: Double, _ number2: Double) -> Double {
        return substractOperation.operate(number1, number2)
    }
    
    // 곱하기
    func multiply(_ number1: Double, _ number2: Double) -> Double {
        return multiplyOperation.operate(number1, number2)
    }
    
    // 나누기
    func divide(_ number1: Double, _ number2: Double) -> Double {
        return divideOperation.operate(number1, number2)
    }
    
    // 나머지 연산
//    func remind(_ number1: Int, _ number2: Int) -> Int {
//        print("remind Int")
//        return number1 % number2
//    }
    
    func remind(_ number1: Double, _ number2: Double) -> Double {
        print("remind Double")
//        return Int(number1) % Int(number2)
        return remindOperation.operate(number1, number2)
    }
    
    func calculate(_ operatorType: OperatorType, _ number1: Double, _ number2: Double) -> Double {
//        if operatorType == OperatorType.add {
//            return addOperation.operate(number1, number2)
//        } else if operatorType == OperatorType.substract {
//            return substractOperation.operate(number1, number2)
//        } else if operatorType == OperatorType.multiply {
//            return multiplyOperation.operate(number1, number2)
//        } else if operatorType == OperatorType.divide {
//            return divideOperation.operate(number1, number2)
//        }
//        return 0
        
        
//        switch operatorType {
//        case .add:
//            return addOperation.operate(number1, number2)
//        case .substract:
//            return substractOperation.operate(number1, number2)
//        case .multiply:
//            return multiplyOperation.operate(number1, number2)
//        case .divide:
//            return divideOperation.operate(number1, number2)
//        default:
//            return 0
//        }
        
        let operation: AbstractOperation
        
        switch operatorType {
        case .add:
            operation = addOperation
        case .substract:
            operation = substractOperation
        case .multiply:
            operation = multiplyOperation
        case .divide:
            operation = divideOperation
        case .remind:
            operation = remindOperation
        }
        
        return operation.operate(number1, number2)
    }
    
}
    

let calculator = Calculator(addOp: AddOperation(), substractOp: SubstractOperation(), multiplyOp: MultiplyOperation(), divideOp: ExtendDivideOperation(), remindOp: RemindOperation())
let addResult = calculator.calculate(.add, 1, 3)
print("addResult : \(addResult)")

let substract = calculator.calculate(.substract, 2, 3)
print("substract : \(substract)")

let multiply = calculator.calculate(.multiply, 2, 3)
print("multiply : \(multiply)")

let divide = calculator.calculate(.divide, 2, 3)
print("divide : \(divide)")

let remind = calculator.calculate(.remind, 3, 5)
print("remind : \(remind)")

//let addResult = calculator.add(1, 2)// 덧셈 연산
//let subtractResult = calculator.substract(3, 4)// 뺄셈 연산
//let multiplyResult = calculator.multiply(5, 6)// 곱셈 연산
//let divideResult = calculator.divide(12, 0)// 나눗셈 연산
//let remindResult = calculator.remind(10, 3)//나머지 연산
//let remindResult2 = calculator.remind(3.14, 3)//나머지 연산

//print("addResult : \(addResult)")
//print("subtractResult : \(subtractResult)")
//print("multiplyResult : \(multiplyResult)")
//print("divideResult : \(divideResult)")
//print("remindResult : \(remindResult)")
//print("remindResult2 : \(remindResult2)")
