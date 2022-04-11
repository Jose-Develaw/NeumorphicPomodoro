//
//  HistoryView.swift
//  NeumorphicPomodoro
//
//  Created by José Ibáñez Bengoechea on 9/4/22.
//

import SwiftUI

struct HistoryView: View {
    
    init(){
        UITableView.appearance().backgroundColor = .clear
    }
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var pomodoroSessions : FetchedResults<PomodoroSession>
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @GestureState private var dragOffset = CGSize.zero
    
    var btnBack : some View { Button(action: {
            self.presentationMode.wrappedValue.dismiss()
            }) {
               
                Image(systemName: "arrowshape.turn.up.backward")
                    .font(.title2)// set image here
                    .foregroundStyle(LinearGradient(.purple, .pink))
                
            }
        }
    
    var body: some View {
        VStack{
            List{
                Section {
                    ForEach(pomodoroSessions) { session in
                        NavigationLink{
                            Text(session.unwrappedTask)
                        } label: {
                            
                            VStack (alignment: .leading){
                                Text(session.unwrappedTask)
                                    .font(.title3)
                                Text(session.unwrappedType)
                                    .foregroundColor(.gray)
                            }
                            .padding(5)
                            
                        }
                        .listRowSeparatorTint(.gray, edges: .all)
                        .listRowBackground(Color.offWhite)
                        
                        
                    }
                    .onDelete(perform: deleteSessions)
                } header: {
                    Text("11/04/2022")
                }
            }
            .listStyle(PlainListStyle())
        }
        .background(Color.offWhite)
        .navigationTitle("History")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: btnBack)
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing){
                EditButton()
                    .foregroundStyle(LinearGradient(.purple, .pink))
            }
        }
        .gesture(DragGesture().updating($dragOffset, body: {(value, state, transaction) in
                if(value.startLocation.x < 30 && value.translation.width > 100) {
                    self.presentationMode.wrappedValue.dismiss()
                }
                    
        }))
    }
    
    func deleteSessions(at offsets: IndexSet){
        for offset in offsets {
            let session = pomodoroSessions[offset]
            moc.delete(session)
        }
        try? moc.save()
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
