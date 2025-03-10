import SwiftUI

struct ContactCard: View {
    @State var next = false
    @State var selectedUser: ContactModel?
    @ObservedObject var viewModel: ContactViewModel
    var onSelect: (ContactModel) -> Void
    let height: CGFloat
    var body: some View {
        GeometryReader { scale in
            ZStack {
                VStack {
                    scenarioBackground(scale)
                        .overlay {
                            if viewModel.contact.isEmpty {
                                ScrollView {
                                    VStack {
                                        Text("저장된 연락처가 없습니다")
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
                viewModel.fetchContacts()
            }
            .refreshable {
                withAnimation(.easeIn(duration: 0.5)) {
                    viewModel.fetchContacts()
                }
            }
            .frame(width: scale.size.width, height: 526)
            .navigationDestination(isPresented: $next) {
                if let user = selectedUser {
                    ContactMoreView(user: user, callViewModel: CallViewModel())
                        .navigationBarBackButtonHidden()
                }
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
            scenarioList(scale)
        }
    }
    
    private func scenarioHeader() -> some View {
        HStack {
            Text("연락처")
                .font(.pretendard(.semibold, size: 16))
                .padding(.top,20)
                .padding(.leading,20)
                .padding(.bottom,10)
                .foregroundStyle(Color(hex: "2B7FFF"))
            Spacer()
        }
    }
    
    private func scenarioList(_ scale: GeometryProxy) -> some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.contact, id: \.id) { newContact in
                    contactRow(newContact, scale)
                        .onTapGesture {
                            selectedUser = newContact
                            next = true
                            onSelect(newContact)
                        }
                }
            }
        }
    }
    
    private func contactRow(_ newContact: ContactModel, _ scale: GeometryProxy) -> some View {
        
        HStack(spacing: 10) {
            AsyncImage(url: URL(string: newContact.profile_url)) { image in
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
                Text(newContact.name)
                    .font(.pretendard(.semibold, size: 18))
                Text(newContact.content)
                    .lineLimit(1)
                    .font(.pretendard(.medium, size: 16))
            }
            Spacer()
        }
        .frame(width: scale.size.width, height: 80)
        .padding(.leading, 27)
        
        
        
    }
}







