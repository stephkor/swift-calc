//
//  ContentView.swift
//  swift-calc
//
//  Created by 한수민 on 3/3/24.
//

import SwiftUI

enum ButtonType: String {
    case first, second, third, fourth, fifth, sixth, seventh, eighth, nineth, zero
    case comma, equal, plus, minus, multiply, divide
    case percent, opposite, clear
   
        var buttonDisplayName: String {
            switch self {
            case .first:
                return "1"
            case .second:
                return "2"
            case .third:
                return "3"
            case .fourth:
                return "4"
            case .fifth:
                return "5"
            case .sixth:
                return "6"
            case .seventh:
                return "7"
            case .eighth:
                return "8"
            case .nineth:
                return "9"
            case .zero:
                return "0"
            case .comma:
                return "."
            case .equal:
                return "="
            case .plus:
                return "+"
            case .minus:
                return "-"
            case .multiply:
                return "X"
            case .divide:
                return "/"
            case .percent:
                return "%"
            case .opposite:
                return "$"
            case .clear:
                return "C"
            }
        }
    

    
    var backgroundColor: Color {
        switch self {
        case .first, .second, .third, .fourth, .fifth, .sixth, .seventh, .eighth, .nineth, .zero:
            return Color("NumberButton")
        case .divide, .equal, .plus, .minus, .multiply:
            return Color.orange
        case .opposite, .percent, .clear:
            return Color.gray
        default:
            return Color.gray
        }
    }
    
    var foregroundColor: Color {
        switch self {
        case .opposite, .percent, .clear:
            return Color.black
        default:
            return Color.white
        }
    }
}

struct ContentView: View {
    
    @State private var totalNumber: String = "0"
    @State private var tempNumber: Double = 0
    @State private var operatorType: ButtonType?
    @State private var isInt: Bool = false
    
    
    
    
    private let buttonData: [[ButtonType]] = [
        [.clear, .opposite, .percent, .divide],
        [.seventh, .eighth, .nineth, .multiply],
        [.fourth, .fifth, .sixth, .minus],
        [.first, .second, .third, .plus],
        [.zero, .comma, .equal]
    ]
    
    
    
    
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                  
                        
                    
                    Text(totalNumber)
                        .padding()
                        .font(.system(size: 73))
                        .foregroundColor(.white)
                }
                
                ForEach(buttonData, id: \.self) { line in
                    HStack {
                        ForEach(line, id: \.self) { item in
                            Button(action: {
                                handleButtonPress(item)
                            }) {
                                
                                Text(item.buttonDisplayName)
                                    .frame(width: item == .zero ? 170 : 80, height: 80)
                                    .background(item.backgroundColor)
                                    .cornerRadius(40)
                                    .foregroundColor(item.foregroundColor)
                                    .font(.system(size: 33))
                            }
                        }
                    }
                }
            }
        }
    }
    
    func isInteger(_ str: String) -> Bool {
        let totalInt = str.split(separator: ".")
      
        if totalInt[1] == "0" {
            return true
        } else {return false}
    }

    
    private func checkIfInteger(_ str: String) -> String  {
        let totalInt = str.split(separator: ".")
        print(totalNumber, totalInt)
      
        
        if totalInt[1] == "0" {
            let totalNum = str.split(separator: ".")[0]
            
            totalNumber = "\(totalNum)"
        } else{
            totalNumber = str
        }
        return totalNumber
    }
    
    private func handleButtonPress(_ buttonType: ButtonType) {
        // Check if totalNumber contains a decimal point
       
        
        switch buttonType {
        case .clear:
            totalNumber = "0"
            operatorType = nil
        case .plus, .minus, .multiply, .divide:
            operatorType = buttonType
            tempNumber = Double(totalNumber) ?? 0
            totalNumber = "0"
        case .equal:
            if let operatorType = operatorType {
                let secondNumber = Double(totalNumber) ?? 0
                
                switch operatorType {
                case .plus:
                    totalNumber = checkIfInteger("\(tempNumber + secondNumber)")
                case .minus:
                    totalNumber = checkIfInteger("\(tempNumber - secondNumber)")
                case .multiply:
                    totalNumber = checkIfInteger("\(tempNumber * secondNumber)")
                case .divide:
                    totalNumber = checkIfInteger("\(tempNumber / secondNumber)")
                        
                default:
                    break
                }
                self.operatorType = nil
            }
        default:
            if totalNumber == "0" || totalNumber == "Error" {
                totalNumber = buttonType.buttonDisplayName
            } else {
                totalNumber += buttonType.buttonDisplayName
            }
        }
    }
    }



#Preview {
    ContentView()
}
