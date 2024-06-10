import SwiftUI
import GoogleSignInSwift

struct ContentView: View {
    @State private var viewController: UIViewController?
    @State private var isPresentMainCalander = false
    @State private var isPresent = false
    @StateObject private var viewModel = GoogleSignInViewModel()
    var body: some View {
        NavigationStack{
            VStack {
                if let user = viewModel.user {
                    Text("Welcome, \(user.profile?.name ?? "User")")
                    
                    Button("Show Events") {
                        self.isPresentMainCalander = true
                    }

                    Button("Sign Out") {
                        viewModel.signOut()
                        viewModel.user = nil
                    }
                    
                } else {
                    GoogleSignInButton {
                        let rootViewController = UIApplication.shared.windows.first?.rootViewController
                        self.viewController = rootViewController
                        
                        self.viewController = rootViewController
                           
                        if let viewController = self.viewController {
                            viewModel.googleSignIn(viewController: viewController, hint: "", additionalScopes: [calanderReadWriteScope]) { result, error in
                                guard error == nil else { return }
                                guard let result = result else { return }
                                viewModel.user = result.user
                                self.isPresentMainCalander = true
                            }
                        }
                    }
                }
            }
            .navigationDestination(isPresented: $isPresentMainCalander) {
                MainCalendarView()
            }
            
        }
    }
}


#Preview {
    ContentView()
}
