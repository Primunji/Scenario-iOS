
import SwiftUI

struct RecentCard: View {
    @State var next = false
    @State var alertOn = false

    @ObservedObject var viewModel: ScenarioViewModel
    let height: CGFloat

    var body: some View {
        GeometryReader { scale in
            ZStack {
                VStack {
                    scenarioBackground(scale)
                        .overlay {
                            scenarioBackground(scale)
                            scenarioContent(scale)
                                .foregroundStyle(.black)
                        }
                }
                .frame(width: scale.size.width, height: scale.size.height)
            }
            .onAppear {
                viewModel.fetchScenario()
            }
            .frame(width: scale.size.width, height: 526)
            .navigationDestination(isPresented: $next) {
                ContactMoreView()
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
            Text("내역")
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
                ForEach(viewModel.scenario, id: \.id) { newRecent in
                    recentRow(newRecent, scale)
                }
            }
        }
    }

    private func recentRow(_ newRecent: ScenarioModel, _ scale: GeometryProxy) -> some View {
        Button {
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
                    Text(newRecent.content)
                        .lineLimit(1)
                        .font(.pretendard(.medium, size: 16))
                }
                Spacer()
            }
            .frame(width: scale.size.width, height: 80)
            .padding(.leading, 27)
            
        }
    }
}



#Preview {
    RecentCard(viewModel: ScenarioViewModel(), height: 499)
}


//
//RoundedRectangle(cornerRadius: 10)
//    .frame(width: scale.size.width * 1,height: 499)
//    .foregroundColor(.white)
//    .overlay {
//        VStack {
//            HStack {
//                Text("연락처")
//                    .font(.pretendard(.semibold, size: 16))
//                    .padding(20)
//                    .foregroundStyle(Color(hex: "2B7FFF"))
//                Spacer()
//            }
//            ForEach(1..<5) { user in
//                ContactUser().padding(.bottom,7)
//            }
//            Spacer()
//        }
//    }
