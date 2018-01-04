//
//  ELCustomPickerView+SingleComponent.swift
//  ELPickerView
//
//  Created by Elenion on 2018/1/4.
//  Copyright © 2018年 Elenion. All rights reserved.
//

import Foundation

public typealias ELCustomPickerView<T> = ELPickerView<ELPickerDataMask<T>>

public extension ELPickerView where T: ELCustomPikcerDataMaskType {
    
    public typealias SingleItemConfigHandler = (_ item: T.K) -> String
    
    /// Function used to transform Item into String. If the Item is String kind, itemConfigHandler is not necessory to be set. DEPRECATED: Use setItemConfigHandler method with ELCustomPickerViewType
    @available(*, deprecated, message: "Use setItemConfigHandler method with ELCustomPickerViewType")
    public func setItemConfigHandler(_ handler: @escaping SingleItemConfigHandler) {
        setItemTransformHandler { (item) -> String in
            return handler(item.object)
        }
    }
    
    var itemConfigHandler: ItemTransformHandler {
        return itemTransformHandler
    }
}

public extension ELPickerView {
    
    @available(iOS, obsoleted: 1.0 , message: "Use static func: pickerView<K>(pickerType: ELPickerViewType, items: [K])")
    public convenience init?<D>(pickerType: ELPickerViewType, items: [D]) {
        self.init(coder: NSCoder())
    }
    
    @available(*, deprecated, message: "Use init(pickerType: ELPickerViewType, items: [T]) method with ELCustomPickerViewType")
    public static func create<K>(pickerType: ELPickerViewType, items: [K]) -> ELCustomPickerView<K> {
        let itemMasks = items.map { (item) -> ELPickerDataMask<K> in
            return ELPickerDataMask(object: item)
        }
        return ELCustomPickerView<K>.init(pickerType: pickerType, items: itemMasks)
    }
    
}

public protocol ELCustomPikcerDataMaskType: ELPikcerDataType {
    associatedtype K: Any
    
    var object: K { get set }
    
}

public struct ELPickerDataMask<T>: ELCustomPikcerDataMaskType, ELPikcerDataType {
    
    public typealias K = T
    
    public var subData: [ELPikcerDataType] = []
    
    public var object: T
    
    init(object: T) {
        self.object = object
    }
}
