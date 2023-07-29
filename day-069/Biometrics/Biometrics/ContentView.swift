//
//  ContentView.swift
//  Biometrics
//
//  Created by nfls on 28/07/2023.
//

import LocalAuthentication
import SwiftUI

struct ContentView: View {
    
    @State private var isAuthenticated = false
    
    var body: some View {
        VStack {
            if isAuthenticated {
                Text("Unlocked")
            }
            else {
                Text("Locked")
            }
        }
        .onAppear {
            authenticate()
        }
    }

    func authenticate() {
        let context = LAContext()
        var error: NSError?

        // check whether biometric authentication is possible
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // it's possible, so go ahead and use it
            let reason = "We need to unlock your data."

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                // authentication has now completed
                if success {
                    isAuthenticated = true
                } else {
                    // there was a problem
                }
            }
        } else {
            // no biometrics
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
