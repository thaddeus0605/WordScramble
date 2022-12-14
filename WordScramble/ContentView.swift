//
//  ContentView.swift
//  WordScramble
//
//  Created by Thaddeus Dronski on 12/10/22.
//

import SwiftUI

struct ContentView: View {
    @State private var userWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""

    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.never)
                }
                
                Section {
                    ForEach(userWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                        
                    }
                }
            }
            .navigationTitle(rootWord)
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
        }
    }
    
    func addNewWord() {
        //lowercase and trim word to make sure we don't add duplicate words with case differences
        let transformWord = newWord.lowercased().trimmingCharacters(in: .whitespaces)
        
        //exit if the reamingn string is empty
        guard transformWord.count > 0 else { return }
        
        //extra validation to come
        withAnimation {
            userWords.insert(transformWord, at: 0)
        }
        newWord = " "
        
    }
    
    func startGame() {
        //find start.txt in our bundle
        if let startFileURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            //load the file into a string
            if let startString = try? String(contentsOf: startFileURL) {
                //split the string into an array of strings with each element being one word.
                let startArray = startString.components(separatedBy: "\n")
                    //pick one random word or use "silkworm" as a sensible default:
                rootWord = startArray.randomElement() ?? "silkworm"
                
                return
            }
        }
        
        fatalError("Could not load start.txt from bundle")
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
//struct ContentView: View {
//    var body: some View {
//        Text("Hello world")
//            .padding()
//    }
//
//    func test() {
////        let input = "a b c"
////        let letters = input.components(separatedBy: " ")
////        let letter = letters.randomElement()
////
////        let trimmed = letter?.trimmingCharacters(in: .whitespacesAndNewlines)
//
//        let word = "swift"
//        let checker = UITextChecker()
//
//        let range = NSRange(location: 0, length: word.utf16.count)
//        let misspelledReange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 9, wrap: false, language: "en")
//
//        let allGood = misspelledReange.location == NSNotFound
//    }
//}

//// loading resources from your app bundle
//struct ContentView: View {
//    var body: some View {
//        Text("Hello world!")
//    }
//
//    func loadFile() {
//        if let fileURL = Bundle.main.url(forResource: "some-file", withExtension: "txt") {
//            if let fileContents = try? String(contentsOf: fileURL) {
//                //we loaded file into string
//                fileContents
//            }
//        }
//    }
//}


//LISTS
//struct ContentView: View {
//
//    let people = ["Finn", "Leia", "Luke", "Rey"]
//    var body: some View {
//        List {
//          Text("Static Row")
//
//            ForEach(people, id: \.self) {
//                Text($0)
//            }
//
//            Text("Static Row")
//        }
//    }
//}
