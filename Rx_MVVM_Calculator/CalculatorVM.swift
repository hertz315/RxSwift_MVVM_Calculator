//
//  CalculatorVM.swift
//  Rx_MVVM_Calculator
//
//  Created by Jeff Jeong on 2022/10/20.
//

import Foundation
import RxRelay
import RxSwift

// 숫자 (계산) 숫자
// MARK: - ViewModel
/// 로직 생각하기
///  계산기의 비즈니스 로직이 뭘까?
///
class CalculatorVM {
    
    /// 첫번째 인풋라벨의 정보를 담고있을 비즈니스 로직 변수 생성
    var firstInput  = BehaviorRelay<Int>(value: 0)
    
    /// 두번째 인풋라벨의 정보를 담고있을 비즈니스 로직 변수 생성
    var secondInput  = BehaviorRelay<Int>(value: 0)
    
    /// 계산의 비즈니스로직 변수를 생성
    var formula = BehaviorRelay<Calculate?>(value: nil)
    
    /// 계산의 벨류를 담고있을 비즈니스로직 변수 생성
    var resultValue = BehaviorRelay<Int>(value: 0)
    
    init(){
        
    }
    
    /// 계산버튼을 눌렀을때 View에서 호출당할 비즈니스 로직 함수
    func handleFormulaAction(_ formulaAction: Calculate){
        /// accept는 보내는거
        self.formula.accept(formulaAction)
    }
    
    /// 계산 버튼(+,-,*,%) 을 눌루지 않았다면
    /// 숫자 버튼을 통해 들어온 숫자를 View에 보내는 로직
    func handleInputNumbers(_ number: Int){
        /// 만약 게산 비즈니스 로직 변수가 연결되지 않았다면
        /// 첫번째 인풋라벨의 정보를 담고있는 비즈니스 로직 변수에
        /// 숫자 버튼을 통해 들어온 숫자를 흘려 보낸다
        /// 그리고 리턴한다
        if self.formula.value == nil {
            self.firstInput.accept(number)
            return
        }
        /// 만약 계산 비즈니스 로직 변수가 nil이 아니라면
        /// 두번째 라벨에 숫자 버튼을 통해 돌어온 숫자를 흘려 보낸다
        self.secondInput.accept(number)
    }
    
    /// 합계를 계산하는 비즈니스 로직
    func doCaluculate(){
        /// firstInput 을 통해 마지막으로 흘려보낸 값을 지역변수 firstValue에 저장
        let firstValue = self.firstInput.value
        /// secondInput 을 통해 마지막으로 흘려보낸 값을 지역변수 secondValue에 저장
        let secondValue = self.secondInput.value
        
        /// 계산의 합을 담을 변수 생성
        var resultValue : Int = 0
        
        /// 먼저 계산변수의 마지막 상태를 언래핑 하고
        /// 계산 변수의 타입에 따라 계산을 실행함
        if let formula = self.formula.value {
            switch formula {
            case .plus:
                resultValue = firstValue + secondValue
            case .minus:
                resultValue = firstValue - secondValue
            case .multiply:
                resultValue = firstValue * secondValue
            case .divide:
                resultValue = firstValue / secondValue
            case .empty:
                return
            }
        }
        
        /// 계산의 결과를 흘려보낼 변수에 계산 결과값을 흘려보냄
        self.resultValue.accept(resultValue)
        /// 첫번째인풋 값을 0으로 흘려보냄
        self.firstInput.accept(0)
        /// 두번째 인풋 값을 0으로 흘려보냄
        self.secondInput.accept(0)
        /// 계산 상태를 nil로 흘려보냄
        self.formula.accept(nil)
    }
}
