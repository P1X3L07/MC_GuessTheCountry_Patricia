//
//  ContentView.swift
//  TestW04
//
//  Created by Christian on 06/10/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var count = 0
    @State var country = ""
    @State var correct = 0
    @State var wrong = 0
    @State var select:[String] = []
        
    var asean = ["Indonesia", "Singapore", "Malaysia", "Laos", "Philipines", "Cambodia", "Myanmar", "Thailand", "Brunei", "Vietnam"]
    @State var results = false
    
    var body: some View {
        ZStack{
            Color.mint
                .ignoresSafeArea()
            VStack{
                Text("Pilih Bendera dari Negara : ")
                    .foregroundStyle(.black).font(.system(size: 25, weight: .bold))
                Text(country)
                    .foregroundStyle(.black).font(.system(size: 25, weight: .bold)).onAppear{randomCountry()}
            }
          
        }
        
        HStack{
            Spacer()
            VStack{
                ForEach(0..<5) { number in
                    Button(action: {
                        self.didTap(number: number)
                    }, label: {
                        
                        Image(asean[number])
                            .resizable()
                            .frame(width:115,height: 75)
                    })
                    
                    
                }
            }
            Spacer()
            VStack{
                ForEach(5..<10) { number in
                    Button(action: {
                        self.didTap(number: number)
                    }, label: {
                        Image(asean[number])
                            .resizable()
                            .frame(width:115,height: 75)
                    })
                    
                }
            }
            Spacer()
            
        }
        .alert(isPresented:$results) {
            Alert(
                title: Text("You have finished the game!!"),
                message: Text("Win : \(correct)  Lose : \(wrong)"),
                primaryButton: .destructive(Text("Restart")) {
                    select.removeAll()
                    count = 0
                    correct = 0
                    wrong = 0
                    randomCountry()
                },
                secondaryButton: .cancel()
            )
        }
        
    }
    
    func randomCountry(){
        if (select.count < 10) {
            var randCountry = asean.randomElement()!
            while select.contains(randCountry){
                randCountry = asean.randomElement()!
            }
            select.append(randCountry)
            country = randCountry
        }
        
    }
    
    func didTap(number: Int) {
        if asean[number] == country {
            correct += 1
        } else {
            wrong += 1
        }
        count += 1
            // Check if you have more countries to select
        if count < 10 {
            randomCountry()
        } else {
            // If you have selected 10 countries, show the results and restart the game
            results = true
            // Reset the game
            select.removeAll()
            count = 0
        }
        
                
    }
    
}

#Preview {
    ContentView()
}
