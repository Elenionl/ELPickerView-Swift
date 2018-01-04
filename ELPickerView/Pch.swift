/*
 **The MIT License**
 **Copyright © 2017 Hanping Xu**
 **All rights reserved.**
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */


import Foundation

/// Width of Screen
private let screenWidth = UIScreen.main.bounds.size.width
/// Height of Screen
private let screenHeight = UIScreen.main.bounds.size.height

public typealias ELCustomPickerViewType = ELPickerViewType

/// ELCustomPickerViewType. The Picker View can only have one component by now, will add more pickerType in future.
///
/// - singleComponent: Picker View with only one component
/// - multiComponents: Picker View with more than one component
public enum ELPickerViewType {
    case singleComponent
    case multiComponents(UInt)
    //    case date
    //    case time
    
    var components: Int {
        switch self {
        case .singleComponent:
            return 1
        case .multiComponents(number):
            return Int(number)
        }
    }
    
    static var multiComponents: ELPickerViewType {
        return ELPickerViewType.multiComponents(2)
    }
    
    static var tribleComponents: ELPickerViewType {
        return ELPickerViewType.multiComponents(3)
    }
}

public protocol ELPikcerDataType {
    var subData: [ELPikcerDataType] {get set}
}

public extension ELPikcerDataType {
    
    subscript(index: Int) -> ELPikcerDataType {
        get {
            return subData[index]
        }
        set {
            subData[index] = newValue
        }
    }
}

