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
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var pomodoroSessions : FetchedResults<PomodoroSession>
    
    var groupedByDate : [Date: [PomodoroSession]] {
        Dictionary(grouping: pomodoroSessions, by: {$0.unwrappedDate})
    }
    
    var headers: [Date] {
        groupedByDate.map({$0.key}).sorted().reversed()
    }
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @GestureState private var dragOffset = CGSize.zero
    
    var btnBack : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
        }) {
           
            Image(systemName: "arrowshape.turn.up.backward")
                .font(.title2)
                .foregroundStyle(LinearGradient(.purple, .pink))
            
        }
    }
    
    var body: some View {
        VStack{
            List{
                ForEach(headers, id: \.self) { header in
                    Section {
                        ForEach(groupedByDate[header]!) { session in
                            NavigationLink{
                                DetailView(pomodoroSession: session)
                            } label: {
                                
                                VStack (alignment: .leading){
                                    Text(session.unwrappedTask)
                                        .font(.title3)
                                        .lineLimit(1)
                                    Text(session.unwrappedType)
                                        .foregroundColor(.gray)
                                }
                                .padding(10)
                                
                            }
                            .listRowSeparator(.visible)
                            .listRowSeparatorTint(.gray, edges: .all)
                            .listRowInsets(EdgeInsets(top: 2, leading: 5, bottom: 2, trailing: 10))
                            .listRowBackground(Color.offWhite)
                        }
                        .onDelete(perform: deleteSessions)
                    } header: {
                        HStack{
                            Text(header.formatted(date: .abbreviated, time: .omitted).capitalizingFirstLetter())
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                                .background(ShallowConcaveView(cornerRadius: 10))
                        }
                        .padding(.trailing)
                        
                    }
                }
            }
            .accentColor(.pink)
            .listStyle(.sidebar)
            .padding(.vertical, 4)
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
