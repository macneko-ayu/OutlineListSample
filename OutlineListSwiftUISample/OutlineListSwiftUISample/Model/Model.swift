//
// Created by Kojiro Yokota on 2021/02/20.
//

public enum Kind: String, CaseIterable {
    case animal, food

    var description: String {
        switch self {
        case .animal:
            return "動物"
        case .food:
            return "食べ物"
        }
    }
}

public enum Animal: String, CaseIterable {
    case dog, cat

    var description: String {
        switch self {
        case .dog:
            return "犬"
        case .cat:
            return "猫"
        }
    }

    var names: [String] {
        switch self {
        case .dog:
            return ["柴犬", "ヨークシャテリア", "ミニチュアシュナウザー"]
        case .cat:
            return ["アメリカンショートヘア", "ノルウェージャンフォレストキャット", "三毛猫"]
        }
    }
}

public enum Food: String, CaseIterable {
    case meat, vegetable

    var description: String {
        switch self {
        case .meat:
            return "肉"
        case .vegetable:
            return "野菜"
        }
    }

    var names: [String] {
        switch self {
        case .meat:
            return ["豚肉", "牛肉", "馬肉"]
        case .vegetable:
            return ["セロリ", "ブロッコリー", "トマト"]
        }
    }
}
