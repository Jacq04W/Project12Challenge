//
//  ContentView.swift
//  Project12Challenge
//
//  Created by Jacquese Whitson on 12/31/23.
//

import SwiftUI




struct Response : Codable{
    var results: [Person]
}
struct Person: Codable, Identifiable {
    var id: String
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: String
    var tags: [String]
    var friends: [Friend]

    
}
struct Friend: Codable, Identifiable {
    var id: String
    var name: String
}


struct ContentView: View {
    @State private var results : [Person] = []
 
    var body: some View {
        NavigationStack{
            VStack {
                List(results,id: \.id){
                    person in
                    
                    NavigationLink{
                        DetailView(person: person)
                    } label : {
                    VStack(alignment: .leading){
                        Text(person.name)
                            .font(.title)
                            .foregroundStyle(.red)
                        
                        Text("is Active? \(person.isActive.description)")
                            .font(.caption)
                            .foregroundStyle(.gray)
                        
                        //                    ForEach(person.friends,id: \.id){ friend in
                        //                        Text(friend.name)
                        //
                        //                    }
                        
                    }
                }
                }.listStyle(.plain)
                
                
                //            ForEach(friends,id: \.id){
                //                person in
                //                VStack{
                //                     Text(person.name)
                //                    Text(person.id)
                //
                //
                //                }
                //            }
            }
            .onAppear {
                Task{
                    await loadData2()
                }
            }
            
            .padding()
        }
    }
    
    func fetchData() {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error)")
            } else if let data = data {
                do {
                    let decodedPersons = try JSONDecoder().decode([Person].self, from: data)
                    DispatchQueue.main.async {
                        self.results = decodedPersons
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }.resume()
    }
    
    
    
    func loadData2() async {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedPersons = try JSONDecoder().decode([Person].self, from: data)
            results = decodedPersons
            print("Data loaded and decoded successfully")
        } catch {
            print("Error loading or decoding data: \(error)")
        }
    }

    
    
 }




struct DetailView: View {
    var person: Person
    @State private var results : [Person] = []

    var body: some View {
        VStack{
//            Text(person.age.description)
//            Text(person.email)
//            Text(person.about)

            Text(person.email)
            
                ForEach(person.friends) { friends in
                    HStack{
                    Text(friends.name)
                    
                }
            }

            
        }
        .onAppear {
            Task{
                await loadData2()
            }
        }
    }
                
                func loadData2() async {
                    guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
                        print("Invalid URL")
                        return
                    }

                    do {
                        let (data, _) = try await URLSession.shared.data(from: url)
                        let decodedPersons = try JSONDecoder().decode([Person].self, from: data)
                        results = decodedPersons
                        print("Data loaded and decoded successfully")
                    } catch {
                        print("Error loading or decoding data: \(error)")
                    }
                }
}

#Preview {
//    ContentView()
    DetailView(person:Person(id: "", isActive: false, name: "", age: 0, company: "", email: "", address: "", about: "", registered: "", tags: [""], friends: []))
}




