//
//  ContentView.swift
//  MultiplicationTable
//
//  Created by Kevin Li on 8/9/22.
//

import SwiftUI

struct Question {
    let text: String
    let answer: Int
}

struct triAnimal: View {
    var number: Int
    var animal: String
    
    var body: some View {
        ZStack {
            Image(animal)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 90)
                .opacity(0.4)
            
            Text("\(number)")
                .font(.system(size: 40, design: .rounded))
                .fontWeight(.bold)
                .foregroundColor(.black)
            
        }
    }
}

struct ContentView: View {
    @State private var table = 1
    @State private var numb = 5
    @State private var begin = false
    @State private var end = false
    @State private var spot = 0
    @State private var score = 0
    
    @State private var stringAnswer = ""
    @State private var intAnswer = 0
    
    @State private var selection = -1
    
    @State private var questions = [Question]()
    let questionNumbs = [5, 12, 15]
    
    //animation variables
    @State private var animationAmount = 0.0
    
    let animalSelection = ["hippo", "bear", "cow", "crocodile", "rhino", "snake", "gorilla", "parrot", "zebra", "whale", "panda", "penguin"]
    
    
    var body: some View {
        ZStack {
            Color(red: 0.543, green: 0.898, blue: 0.824)
                .ignoresSafeArea()
            
            VStack (spacing: 10){
                
                
                if !begin && !end {
                    Spacer()
                    
                    Text("Animal Tables")
                        .font(.system(size: 53))
                        .fontWeight(.heavy)
                
                    
                    Text("Which tables do you want to practice?")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    VStack {
                        ForEach(1..<5) { multiplier in
                            HStack {
                                ForEach(1..<4) { number in
                                    Button {
                                    withAnimation {
                                            animationAmount += 360
                                        }
                                        table = number + (multiplier * 3 - 3)
                                    } label: {
                                        triAnimal(number: number + (multiplier * 3 - 3), animal: animalSelection[number + (multiplier * 3 - 3) - 1])
                                    }
                                    .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: (number + (multiplier * 3 - 3)) == table ? 1 : 0, z: 0))
                                    .opacity(table == (number + (multiplier * 3 - 3)) ? 0.55 : 0.4)
                                    .scaleEffect(table == (number + (multiplier * 3 - 3)) ? 0.7 : 1)
                                }
                            }
                        }
                    }
                    
                    Spacer()

                    Text("How many questions?")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                    
                    Picker("Number of Question", selection: $numb) {
                        ForEach(questionNumbs, id: \.self) {
                            Text($0, format: .number)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    Spacer()
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 25, style: .continuous)
                            .fill(.white)
                            .frame(width: 150, height: 50)
                            .opacity(1)
    
                        
                        Button("Begin!") {
                            populate(table)
                            begin = true
                        }
                        .foregroundColor(.black)
                    }
                
                }
                
                //next screen for questions
                
                else if begin && !end {
                    Text(questions[spot].text)
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .transition(.opacity)
                    
                    Text("\(stringAnswer)")
                        .font(.system(size: 25))
                        .transition(.opacity)
                        .animation(.default, value: stringAnswer)

                    VStack {
                        ForEach(1..<4) { multiplier in
                            HStack {
                                ForEach(1..<4) { number in
                                    Button {
                                        withAnimation {
                                            animationAmount += 360
                                            selection = (number + (multiplier * 3 - 3))
                                        }
                                        stringAnswer = stringAnswer + "\(number + (multiplier * 3 - 3))"
                                    } label: {
                                        triAnimal(number: number + (multiplier * 3 - 3), animal: animalSelection[number + (multiplier * 3 - 3) - 1])
                                    }
                                    .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: (number + (multiplier * 3 - 3)) == selection ? 1 : 0, z: 0))
                                    .opacity(selection == (number + (multiplier * 3 - 3)) ? 0.55 : 0.4)
                                    .scaleEffect(selection == (number + (multiplier * 3 - 3)) ? 0.7 : 1)
                                }
                            }
                        }
                        HStack {
                            Button {
                                scoreCheck()
                            } label: {
                                ZStack {
                                    Image("pig")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 90)
                                        .opacity(0.4)
                                    Text("Submit")
                                        .font(.system(size: 20, design: .rounded))
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                }
                            }
                            
                            Button {
                                withAnimation {
                                    animationAmount += 360
                                    selection = 0
                                }
                                stringAnswer = stringAnswer + "0"
                            }  label: {
                                ZStack {
                                    Image("whale")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 90)
                                        .opacity(0.4)
                                    
                                    Text("0")
                                        .font(.system(size: 40, design: .rounded))
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                    
                                }
                            }
                            .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: selection == 0 ? 1 : 0, z: 0))
                            .opacity(selection == 0 ? 0.55 : 0.4)
                            .scaleEffect(selection == 0 ? 0.7 : 1)
                            
                            Button {
                                stringAnswer.removeLast()
                            } label: {
                                ZStack {
                                    Image("chick")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 90)
                                        .opacity(0.4)
                                    
                                    Text("X")
                                        .font(.system(size: 40, design: .rounded))
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                    
                                }
                            }
                        }
                        
                    }
                }

                else {
                    Text("Your score was \(score)!")
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 25, style: .continuous)
                            .fill(.white)
                            .frame(width: 150, height: 50)
                            .opacity(1)
    
                        
                        Button("Play Again") {
                            restart()
                        }
                        .foregroundColor(.black)
                    }
                }
            }
            .padding()
        }
    }
    
    func populate(_ y: Int) {
        for x in 1...numb {
            questions.append(Question(text: "\(y) x \(x)", answer: x * y))
        }
    }
    
    func scoreCheck() {
        intAnswer = Int(stringAnswer) ?? 0
        
        if questions[spot].answer == intAnswer {
            score += 1
        }
        
        if spot < numb - 1 {
            spot += 1
        }
        else {
            begin = false
            end = true
        }
        
        stringAnswer = ""
        selection = -1
    }
    
    func restart() {
        begin = false
        end = false
        spot = 0
        score = 0
        questions.removeAll()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
