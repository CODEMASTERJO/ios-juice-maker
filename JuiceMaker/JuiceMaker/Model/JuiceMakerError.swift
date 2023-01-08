//
//  JMError.swift
//  JuiceMaker
//
//  Created by sei_dev on 1/3/23.
//

import Foundation

enum JuiceMakerError: Error {
    case outOfStock
}

extension JuiceMakerError {
    var helpMessage: String {
        switch self {
        case .outOfStock:
            return "재료가 모자라요. 재고를 수정할까요?"
        }
    }
}
