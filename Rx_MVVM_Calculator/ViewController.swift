//
//  ViewController.swift
//  Rx_MVVM_Calculator
//
//  Created by Hertz on 10/20/22.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay

// MARK: - 계산타입 정의
enum Calculate {
    case plus
    case minus
    case multiply
    case divide
    case empty
    
    /// 문자열을 enum클래스의 타입으로 바꿔주는 코드
    static func initialize(_ btnTitle : String) -> Self {
        switch btnTitle {
        case "+": return .plus
        case "%": return .divide
        case "X": return .multiply
        case "-": return .minus
        default: return .empty
        }
    }
    
    /// 계산연산자
    var infoString : String {
        switch self {
        case .plus: return "더하기"
        case .minus: return "빼기"
        case .multiply: return "곱하기"
        case .divide: return "나누기"
        case .empty: return "nil"
        }
    }
}

// MARK: - View
class ViewController: UIViewController {
    
    @IBOutlet weak var firstInputLabel: UILabel!
    
    @IBOutlet weak var formulaLabel: UILabel!
    
    @IBOutlet weak var secondInput: UILabel!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    /// 뷰 모델 생성
    var viewModel : CalculatorVM = CalculatorVM()
    /// 찌꺼기 담을 청소차 출격
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// 뷰모델에 첫번째 인풋에 집어넣을 값을 잡아서
        /// 스킵 연산자를 통해 값을 막아놓고
        /// 맵 연산자를 통해 Int -> String으로 변환한후
        /// ⭐️bind를 통해 드디어 연결⭐️
        /// 그후 찌꺼기 차를 불러 청소
        viewModel
            .firstInput
            .skip(1)
            .map{ "\($0)" }
            .bind(to: firstInputLabel.rx.text)
            .disposed(by: disposeBag)
        
        /// 뷰모델에 두번째 인풋에 집어넣을 값을 잡아서
        /// 스킵 연산자를 통해 값을 막아놓고
        /// 맵 연산자를 통해 Int -> String으로 변환한후
        /// ⭐️bind를 통해 드디어 연결⭐️
        /// disposed를 통해 찌꺼기 차를 불러 청소
        viewModel
            .secondInput
            .skip(1)
            .map{ "\($0)" }
            .bind(to: secondInput.rx.text)
            .disposed(by: disposeBag)
        
        /// 뷰모델에 계산결과를 집어넣을 값을 잡아서
        /// 스킵 연산자를 통해 값을 막아놓고
        /// 맵 연산자를 통해 Int -> String으로 변환한후
        /// ⭐️bind를 통해 드디어 연결⭐️
        /// 그후 찌꺼기 차를 불러 청소
        viewModel
            .resultValue
            .skip(1)
            .map{ "\($0)" }
            .bind(to: resultLabel.rx.text)
            .disposed(by: disposeBag)
        
        /// 뷰모델 계산레이블에 집어넣을 값을 잡아서
        /// ❓compactMap
        /// ⭐️bind를 통해 드디어 연결⭐️
        /// 그후 찌꺼기 차를 불러 청소
        viewModel
            .formula // Calculate
            .compactMap{ $0?.infoString ?? "" } // String
            .bind(to: formulaLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    /// @IBAction
    /// 숫자버튼을 눌르면 실행되는 함수
    @IBAction func touchDigit(_ sender: UIButton) {
        /// 숫자버튼을 누르면 눌른 버튼의 타이틀을 Int자료형으로 변환후 변수에 담고
        var number = Int(sender.currentTitle ?? "") ?? 0
        print(#fileID, #function, #line, "- number: \(number)")
        /// 변수에 담은 값을 ViewModel의 계산로직의 매게변수로 집어넣기
        self.viewModel.handleInputNumbers(number)
    }
    
    
    /// 계산을 실행하는 함수
    @IBAction func formulaAction(_ sender: UIButton) {
        /// 계산타입을 생성하면 로직을 통해 문자열이 Calculate타입으로 바뀐다
        let formulaAction : Calculate = Calculate.initialize(sender.currentTitle ?? "")
        /// 뷰모델의 비즈니스로직 함수의 매게변수에 할당
        self.viewModel.handleFormulaAction(formulaAction)
        
    }
    
    /// 계산버튼을 눌르면 실행하는 함수
    @IBAction func doCalculate(_ sender: UIButton) {
        /// viewModel에 합계를 계산하는 비즈니스 로직을 호출한다
        self.viewModel.doCaluculate()
        
    }
}

