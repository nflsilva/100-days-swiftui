//
//  ContentView.swift
//  Bookworm
//
//  Created by nfls on 19/06/2023.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var students: FetchedResults<Student>
    
    var body: some View {
        VStack {
            List(students) { student in
                Text(student.name ?? "Unknown")
            }
            
            Button("Add") {
                let student = Student(context: moc)
                student.id = UUID()
                student.name = "Student Nº\(students.count)"
                
                try? moc.save()
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
