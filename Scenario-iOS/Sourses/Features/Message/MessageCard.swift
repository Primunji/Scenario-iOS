//
//  MessageCard.swift
//  Scenario-iOS
//
//  Created by dgsw07 on 3/9/25.
//

import SwiftUI

struct MessageCard : View {
    @State var next = false
    @State var alertOn = false
    @ObservedObject var viewModel: MessageViewModel
    @State var selectedUser: ContactModel?
    @State var selectedThread: String
//    var onSelect: (MessageModel) -> Void
    let height: CGFloat
    
    var body: some View {
        GeometryReader { scale in
            ZStack {
                VStack {
                    scenarioBackground(scale)
                        .overlay {
                            if viewModel.messages.isEmpty {
                                ScrollView {
                                    VStack {
                                        Text("메시지 없습니다")
                                            .font(.pretendard(.semibold, size: 18))
                                    }
                                }
                            } else {
                                scenarioBackground(scale)
                                scenarioContent(scale)
                            }
                        }
                }
                .frame(width: scale.size.width, height: scale.size.height)
            }
            .onAppear {
                viewModel.fetchMessageRooms()
            }
            .refreshable {
                withAnimation(.easeIn(duration: 0.5)) {
                    viewModel.fetchMessageRooms()
                }
            }
            .frame(width: scale.size.width, height: 526)
        }.navigationDestination(isPresented: $next) {
            if let user = selectedUser {
                ChatView(user: user, is_first: false, thread_id: selectedThread)
                    .navigationBarBackButtonHidden()
            }
        }
    }

    
    private func scenarioBackground(_ scale: GeometryProxy) -> some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: scale.size.width, height: height)
            .foregroundColor(.white)
            
    }
    
    private func scenarioContent(_ scale: GeometryProxy) -> some View {
        VStack {
            scenarioHeader()
            recentList(scale)
        }
    }
    
    private func scenarioHeader() -> some View {
        
        HStack {
            Text("메시지")
                .font(.pretendard(.semibold, size: 16))
                .padding(.top,20)
                .padding(.leading,20)
                .padding(.bottom,10)
                .foregroundStyle(Color(hex: "2B7FFF"))
            Spacer()
            
        }
    }
    
    private func recentList(_ scale: GeometryProxy) -> some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.messages, id: \.id) { newRecent in
                    recentRow(newRecent, scale)
                }
            }
        }
    }
    
    private func recentRow(_ newRecent: MessageModel, _ scale: GeometryProxy) -> some View {
        Button {
            selectedUser = ContactModel(id: Int(newRecent.id), scenario_id: Int(newRecent.scenario_id), userId: Int(newRecent.userId), name: newRecent.name, content: newRecent.content, profile_url: newRecent.profile_url, created_at: newRecent.created_at)
            print(newRecent.thread_id)
            selectedThread = newRecent.thread_id
            next = true
        } label: {
            HStack(spacing: 10) {
                AsyncImage(url: URL(string: newRecent.profile_url)) { image in
                    image.resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .frame(width: 80, height: 80)
                } placeholder: {
                    Image(systemName: "person.crop.circle.fill")
                        .foregroundColor(Color(hex: "C6C9CB"))
                        .font(.system(size: 60))
                }
                
                VStack(alignment: .leading) {
                    Text(newRecent.name)
                        .font(.pretendard(.semibold, size: 18))
                        .foregroundColor(.black)
                    Text(newRecent.recent_message)
                        .lineLimit(1)
                        .font(.pretendard(.medium, size: 16))
                        .foregroundColor(.black)
                }
                Spacer()
            }
            .frame(width: scale.size.width, height: 80)
            .padding(.leading, 27)
            
        }
    }
}


#Preview {
    MessageView()
}
