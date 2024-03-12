/* Lv1~Lv2
class Calculator2 {
    func add(_ number1: Double, _ number2: Double) -> Double {
        number1 + number2
    }
    
    /**
     
     **/
    func substarct(_ number1: Double, _ number2: Double) -> Double {
        number1 - number2 //한줄이면 리턴 입력하지 않아도 됨
    }
    
    func multiply(_ number1: Double, _ number2: Double) -> Double {
        number1 * number2
    }
    
    func divide(_ number1: Double, _ number2: Double) -> Double {
        guard number2 != 0 else { // 0일 때
            return 0
        }
        return number1 / number2
        
    }
    
    func remain(_ number1: Double, _ number2: Double) -> Int {
        Int(number1) % Int(number2)
    }
}

let calculate = Calculator2()

calculate.add(1, 2)
calculate.remain(6, 3)
 
*/

class AddOperation {
    func add(_ number1: Double, _ number2: Double) -> Double {
        number1 + number2
    }
}
/*
 Parameters:
 
 */
class SubstractOperation{
    func substract(_ number1: Double, _ number2: Double) -> Double {
        number1 - number2 //한줄이면 리턴 입력하지 않아도 됨
    }
}

class MultiplyOperation {
    func multiply(_ number1: Double, _ number2: Double) -> Double {
        number1 * number2
    }
}

class DivideOperation{
    func divide(_ number1: Double, _ number2: Double) -> Double {
        guard number2 != 0 else { // 0일 때
            return 0
        }
        return number1 / number2
    }
}

class Calculator2 {
    //    let addOperation = AddOperation() //생성한 경우
    let addOperation: AddOperation //생성은 하지 않고 인수?에 타입만 정의 한 경우
    let substractOperation = SubstractOperation() //클래스 내부에서 직접 인스턴스를 생성헤서 관리
    let multiplyOperatiion = MultiplyOperation()
    let didvideOperation = DivideOperation()
    
    init(addOperation: AddOperation) {
        self.addOperation = addOperation
    }
    
    func operate(_ operator: OperatorType, _ number1: Double, _ number2:Double) -> Double {
        /*
         if `operator` == "+" {
         return self.addOperation.add(number1, number2)
         }
         return 0
         } */
        
        switch `operator` {
        case .add:
            return addOperation.add(number1, number2)
        case .substract:
            return substractOperation.substract(number1, number2)
        case .multiply:
            return multiplyOperatiion.multiply(number1, number2)
        case .divide:
            return didvideOperation.divide(number1, number2 )
        }
    }
}

//_ operator: String -> String 의 단점 이모지도 받을 수 있음
// 보통은 타입마다 파일 생성 따로 함
enum OperatorType {
    case add
    case substract
    case multiply
    case divide
}

let addOperation = AddOperation() //외부에서 생성한 인스턴스를 받아서 생성?
let calculator = Calculator2(addOperation: addOperation)//칼큘레이터를 생성할 때 인스턴스를 받게 된다? ..이름 다 똑같아서 헷갈려

calculator.operate(.add, 1, 2) //타입 추론이 가능 하니까 .add
