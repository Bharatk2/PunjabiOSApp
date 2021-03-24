//
//  ContentView.swift
//  Login App
//
//  Created by Kavsoft on 13/06/20.
//  Copyright © 2020 Bharat. All rights reserved.
//

import SwiftUI
import FirebaseAuth
import FBSDKLoginKit
import Firebase
import UIKit
import SwiftyJSON
struct LoginView: View {
    var body: some View {
        
        LoginHome(areYouGoingToSecondView3: false)
            // for light status bar...
            .preferredColorScheme(.dark)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

 struct LoginHome : View {
    @ObservedObject var fbmanager = UserLoginManager()
    @State var email = ""
    @State var password = ""
    @State var isFocused = false
    @State var showAlert = false
    @State var alertMessage = "Something went wrong"
    @State var isSuccessful = false
    @State var index = 0
    @State var fbLoginSuccess = false
    @State var areYouGoingToSecondView3: Bool
    @State var isLoading = false
    @State var facebookView = true
    @State private var showingAlert = false
    
   
   
    static var shared = LoginHome(areYouGoingToSecondView3: false)
 
     var body: some View{
        
        GeometryReader{_ in
            NavigationView {
                
            VStack{
                NavigationLink(destination: SideMenu()
                .navigationBarTitle("")
                .navigationBarHidden(true)
                , isActive: self.$areYouGoingToSecondView3) { EmptyView() }
                Image("Logop")
                .resizable()
                .frame(width: 150, height: 135)
                    .shadow(radius: 0)
                
                ZStack{
                   
                    SignUP(index: self.$index, areYouGoingToSecondView2: false)
                        // changing view order...
                        .zIndex(Double(self.index))
                    
                    Login(index: self.$index, areYouGoingToSecondView: false)

                }
                
                HStack(spacing: 15){
                    
                    Rectangle()
                    .fill(Color("PinkColor"))
                    .frame(height: 1)
                    
                    Text("OR")
                    
                    Rectangle()
                    .fill(Color("PinkColor"))
                    .frame(height: 1)
                }
                .padding(.horizontal, 30)
                .padding(.top, 50)
                // because login button is moved 25 in y axis and 25 padding = 50
                
                HStack(spacing: 25){
                    
                    Button(action: {
                        
                    }) {
                        
                        Image("apple")
                        .resizable()
                        .renderingMode(.original)
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                    }
                    
                    Button(action: {
                        
                        if AccessToken.current != nil && self.fbmanager.fbSuccess == true {
                            self.isLoading = true
                            self.facebookView = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                self.isLoading = false
                               
                            }
                            self.areYouGoingToSecondView3 = true
                            
                           
                        } else {
                            self.isLoading = true
                           self.facebookView = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                self.isLoading = false
                                
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                        self.fbmanager.facebookLogin()
                                self.facebookView = true
                            }
                            
                        }
                        
                    }) {
                        
                        Image("fb")
                        .resizable()
                        .renderingMode(.original)
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                    }
                    
                    Button(action: {
                        
                    }) {
                        
                        Image("twitter")
                        .resizable()
                        .renderingMode(.original)
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                    }
                    
                    if self.isLoading {
                            LoadingView()
                        }
                }
                .padding(.top, 30)
            }
            .padding(.vertical)
            }
            
     
         
             .navigationBarBackButtonHidden(true)
        }.onAppear() {
            if AccessToken.current != nil && self.fbmanager.fbSuccess == true {
            self.areYouGoingToSecondView3 = true
            }
        }
    
        .background(Color(.black).edgesIgnoringSafeArea(.all))
     .navigationBarTitle("")
     .navigationBarHidden(true)
    }
}

// Curve...

struct CShape : Shape {
    
    func path(in rect: CGRect) -> Path {
        
        return Path{path in

            // right side curve...
            
            path.move(to: CGPoint(x: rect.width, y: 100))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: 0))
            
        }
    }
}


struct CShape1 : Shape {
    
    func path(in rect: CGRect) -> Path {
        
        return Path{path in

            // left side curve...
            
            path.move(to: CGPoint(x: 0, y: 100))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            
        }
    }
}

struct Login : View {
    @EnvironmentObject var session: SessionStore
    @State var email = ""
    @State var pass = ""
    @State var isFocused = false
    @State var showAlert = false
    @State var alertMessage = "Something went wrong"
    @State var isSuccessful = false
    @State var error: String = ""
    @Binding var index : Int
    @State var areYouGoingToSecondView: Bool
     @State var fbLoginSuccess = false
    @State var isLoading = false
  
    @State var loginView: Bool = LoginHome.shared.facebookView
    
    func signIn() {
        session.signIn(email: email, password: pass) { (result, error) in
            if let error = error {
                self.error = error.localizedDescription
            } else {
                self.email = ""
                self.pass = ""
            }
            if (result != nil) {
                self.areYouGoingToSecondView = true
            }
        }
    }
    var body: some View{
        
        ZStack(alignment: .bottom) {
            
            VStack{
                 NavigationLink(destination: SideMenu()
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                 , isActive: $areYouGoingToSecondView) { EmptyView() }
               
                HStack{
                    
                    VStack(spacing: 10){
                        
                        Text("Login")
                            .foregroundColor(self.index == 0 ? .orange : .gray)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Capsule()
                            .fill(self.index == 0 ? Color.blue : Color.clear)
                            .frame(width: 100, height: 5)
                    }
                    
                    Spacer(minLength: 0)
                }
                .padding(.top, 30)// for top curve...
                
                VStack{
                    
                    HStack(spacing: 15){
                        
                        Image(systemName: "envelope.fill")
                        .foregroundColor(Color("PinkColor"))
                        
                        TextField("Email Address", text: self.$email) {
                            UIApplication.shared.endEditing()
                        }
                    }
                    
                    Divider().background(Color.white.opacity(0.5))
                }
                .padding(.horizontal)
                .padding(.top, 40)
                
                VStack{
                    
                    HStack(spacing: 15){
                        
                        Image(systemName: "eye.slash.fill")
                        .foregroundColor(Color("PinkColor"))
                        
                        SecureField("Password", text: self.$pass) {
                               UIApplication.shared.endEditing()
                        }
                    }
                    
                    Divider().background(Color.white.opacity(0.5))
                }
                .padding(.horizontal)
                .padding(.top, 30)
                
                HStack{
                    
                    Spacer(minLength: 0)
                    
                    Button(action: {
                        
                    }) {
                        
                        Text("Forget Password?")
                            .foregroundColor(Color.white.opacity(0.6))
                    }
                }
                .padding(.horizontal)
                .padding(.top, 30)
            }
            .padding()
            // bottom padding...
            .padding(.bottom, 65)
            .background(Color("BlackColor2"))
            .clipShape(CShape())
            .contentShape(CShape())
            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: -5)
            .onTapGesture {
            
                self.index = 0
                    
            }
            .cornerRadius(35)
            .padding(.horizontal,20)
            
            // Button...
            Button(action: {
                self.isLoading = true
                LoginHome.shared.facebookView = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    self.isLoading = false
                   LoginHome.shared.facebookView = false
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                     self.signIn()
                    LoginHome.shared.facebookView = false 
                }

            }) {
                Text("LOGIN")
                .foregroundColor(.white)
                .fontWeight(.bold)
                .padding(.vertical)
                .padding(.horizontal, 50)
                .background(Color("PinkColor"))
                .clipShape(Capsule())
                // shadow...
                .shadow(color: Color.white.opacity(0.1), radius: 5, x: 0, y: 5)
            }
         
//            Button(action: signIn) {
//           //self.areYouGoingToSecondView = true
//
//                Text("LOGIN")
//                    .foregroundColor(.white)
//                    .fontWeight(.bold)
//                    .padding(.vertical)
//                    .padding(.horizontal, 50)
//                    .background(Color("PinkColor"))
//                    .clipShape(Capsule())
//                    // shadow...
//                    .shadow(color: Color.white.opacity(0.1), radius: 5, x: 0, y: 5)
//            }
            
            // moving view down..
            .offset(y: 25)
            .opacity(self.index == 0 ? 1 : 0)
            if isLoading {
                LoadingView()
            }
        }
.navigationBarTitle("")
.navigationBarHidden(true)
    }
}

// SignUP Page..

struct SignUP : View {
    @Binding var index : Int
    @State var email = ""
    @State var pass = ""
    @State var Repass = ""
    @State var error: String = ""
    @EnvironmentObject var session: SessionStore
    @State var areYouGoingToSecondView2: Bool
    
    
    func signUp() {
        session.signUp(email: email, password: pass) { (result, error) in
            if let error = error {
                self.error = error.localizedDescription
            } else {
                self.email = ""
                self.pass = ""
                
            }
            if (result != nil) {
                self.areYouGoingToSecondView2 = true
            }
        }
    }
    var body: some View{
        
        ZStack(alignment: .bottom) {
            
            VStack{
                NavigationLink(destination: SideMenu(), isActive: $areYouGoingToSecondView2) { EmptyView() }
                HStack{
                    
                    Spacer(minLength: 0)
                    
                    VStack(spacing: 10){
                        
                        Text("SignUp")
                            .foregroundColor(self.index == 1 ? .green : .gray)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Capsule()
                            .fill(self.index == 1 ? Color.blue : Color.clear)
                            .frame(width: 100, height: 5)
                    }
                }
                .padding(.top, 30)// for top curve...
                
                VStack{
                    
                    HStack(spacing: 15){
                        
                        Image(systemName: "envelope.fill")
                        .foregroundColor(Color("PinkColor"))
                        
                        TextField("Email Address", text: self.$email)
                    }
                    
                    Divider().background(Color.white.opacity(0.5))
                }
                .padding(.horizontal)
                .padding(.top, 40)
                
                VStack{
                    
                    HStack(spacing: 15){
                        
                        Image(systemName: "eye.slash.fill")
                        .foregroundColor(Color("PinkColor"))
                        
                        SecureField("Password", text: self.$pass)
                    }
                    
                    Divider().background(Color.white.opacity(0.5))
                }
                .padding(.horizontal)
                .padding(.top, 30)
                
                // replacing forget password with reenter password...
                // so same height will be maintained...
                
                VStack{
                    
                    HStack(spacing: 15){
                        
                        Image(systemName: "eye.slash.fill")
                        .foregroundColor(Color("PinkColor"))
                        
                        SecureField("Password", text: self.$Repass)
                    }
                    
                    Divider().background(Color.white.opacity(0.5))
                }
                .padding(.horizontal)
                .padding(.top, 30)
            }
            .padding()
            // bottom padding...
            .padding(.bottom, 65)
            .background(Color("BlackColor2"))
            .clipShape(CShape1())
            // clipping the content shape also for tap gesture...
            .contentShape(CShape1())
            // shadow...
            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: -5)
            .onTapGesture {
            
                self.index = 1
                    
            }
            .cornerRadius(35)
            .padding(.horizontal,20)
            
            // Button...
            
            Button(action: signUp) {
                
                Text("SIGNUP")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .padding(.horizontal, 50)
                    .background(Color("PinkColor"))
                    .clipShape(Capsule())
                    // shadow...
                    .shadow(color: Color.white.opacity(0.1), radius: 5, x: 0, y: 5)
            }
                
            // moving view down..
            .offset(y: 25)
            // hiding view when its in background...
            // only button...
            .opacity(self.index == 1 ? 1 : 0)
            
            if (error != "") {
                Text(error)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.red)
                .padding()
            }
            Spacer()
        }
    }
}

class UserLoginManager: ObservableObject {
    var fbSuccess = false
    let loginManager = LoginManager()
    
    public class func getFBUserData(completionHandler: @escaping () -> Void) {
           if AccessToken.current != nil {
               GraphRequest(graphPath: "me", parameters: ["fields": "name, email, picture.type(normal)"]).start { (connection, result, error) in
                   
                   if error == nil {
                       let json = JSON(result!)
                       print(json)
                    FBUser.currentUser.setInfo(json: json)
                       completionHandler()
                       
                   }
               }
           }
       }
    func facebookLogin() {
        loginManager.logIn(permissions: [.publicProfile, .email], viewController: nil) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                print("Logged in! \(grantedPermissions) \(declinedPermissions) \(accessToken)")
                GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name"]).start(completionHandler: { (connection, result, error) -> Void in
                    if (error == nil){
                        UserLoginManager.getFBUserData {
                            LoginHome.shared.areYouGoingToSecondView3 = true
                            self.fbSuccess = true
                            let fbDetails = result as! NSDictionary
                            print(fbDetails)
                        }
                        
                        
                    }
                })
                
                
            }
        }
      
    }
    
   
    
    
}
extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
