import Foundation

#if DEBUG
enum StartFlow: String {
    case splash
    case login
    case loginNotInternet
    case loginWrongLogin
}
#endif
