import Foundation

struct ErrorInputData {
    
    let emoji: Character
    let message: String
    let onTryAgain: VoidClosure?
    
}

extension ErrorInputData {

    static let networkConectionLost = ErrorInputData(
        emoji: "📡",
        message: "Network Conection Lost. Please check your internet connection and try again.",
        onTryAgain: nil
    )
    static let serverError = ErrorInputData(
        emoji: "🛠",
        message: "Internal Server Error. Please try again later or contact customer support.",
        onTryAgain: nil
    )
    static let applicationError = ErrorInputData(
        emoji: "🙈",
        message: "Developer mistake. Please try turning it off and on again",
        onTryAgain: nil
    )
    
}
