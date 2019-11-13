//
//  ContentView.swift
//  Flag Game
//
//  Created by Nadya Postriganova on 30/10/19.
//  Copyright © 2019 Nadya Postriganova. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var alertMessage = ""
    @State private var scoreTitle = NSAttributedString(string: "")
    @State private var usersScore = 0
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                         .titleStyle()
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.black)
                        .font(.largeTitle)
                }
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {
                        FlagImage(imageNamed: self.countries[number])
                    }
                }
                Text("Your score is \(usersScore)")
                     .titleStyle()
                    .foregroundColor(.white)
                Spacer()
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle.string), message: Text(alertMessage), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
            })
        }

    }
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func flagTapped(_ number: Int) {
        if correctAnswer == number {
            scoreTitle = NSAttributedString(string: "Correct!", attributes: [.foregroundColor: UIColor.green])
            usersScore += 1
            alertMessage = "Your score is \(usersScore)"
        } else {
            scoreTitle = NSAttributedString(string: "Wrong!", attributes: [.foregroundColor: UIColor.red])
            usersScore -= 1
            alertMessage = "That’s the flag of \(countries[number])"
        }
          showingScore = true
    }
}
struct FlagImage: View {
    var imageNamed: String
    var body: some View {
        
    Image(imageNamed)
        .renderingMode(.original)
        .clipShape(Capsule())
        .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                                .shadow(color: .black, radius: 2)
    }
    
}
struct Title: ViewModifier {
    func body (content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
    }
}
extension View {
    func titleStyle() -> some View {
        self.modifier(Title())
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro"))
        .previewDisplayName("iPhone 11 Pro")
    }
}
