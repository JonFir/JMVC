import Foundation

#if DEBUG
enum StartFlow: String {
    case splash
    case login
    case loginWrongLogin
    case loginNotInternet
}
#endif
