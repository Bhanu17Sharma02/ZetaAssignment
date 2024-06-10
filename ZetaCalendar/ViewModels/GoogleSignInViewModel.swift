//
//  GoogleSignInViewModel.swift
//  ZetaCalendar
//
//  Created by Bhanu Sharma on 10/06/24.
//

import Foundation
import GoogleSignIn
import GoogleAPIClientForREST

class GoogleSignInViewModel : ObservableObject {
   
    @Published var user: GIDGoogleUser? = GIDSignIn.sharedInstance.currentUser
    
    func googleSignIn(
        viewController: UIViewController,
        hint: String,
        additionalScopes: [String]?,
        completion: ((GIDSignInResult?,
        (any Error)?) -> Void)? = nil
    ) {
        
        //Google Sign In Action and Scope.
        GIDSignIn.sharedInstance.signIn(withPresenting: viewController, hint: hint, additionalScopes: additionalScopes) { result, error in
            guard error == nil else {
                completion?(nil,error)
                return
            }
            
            guard let result = result else { return }
            let user = result.user
            //self.isPresentMainCalander = true
            completion?(result,nil)
            
        }
        
        
        
    }
    
    func signOut() {
        GIDSignIn.sharedInstance.signOut()
    }
}
