//
//  Scenario.swift
//  Scenario-iOS
//
//  Created by dgsw07 on 3/9/25.
//
import SwiftUI
import Alamofire

struct ScenarioCard: View {
    @State var next = false
    @State var alertOn = false
    @State var alertOn2 = false
    @State var selectedScenarioId: Int? = nil

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
            .alert(isPresented: $alertOn) {
                Alert(
                    title: Text("연락처에 추가하시겠습니까?"),
                    primaryButton: .cancel(Text("아니요")),
                    secondaryButton: .default(Text("네"), action: {
                        if let scenarioId = selectedScenarioId {
                            viewModel.postScenarioIdToContacts(scenarioId: scenarioId)
                            
                        }
                    })
                )
            }
            .onAppear {
                viewModel.fetchScenario()
            }
            .frame(width: scale.size.width, height: 526)
            .navigationDestination(isPresented: $next) {
                CreateView()
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
            Text("시나리오 목록")
                .font(.pretendard(.semibold, size: 16))
                .padding(.top,20)
                .padding(.leading,20)
                .padding(.bottom,10)
                .foregroundStyle(Color(hex: "2B7FFF"))
            Spacer()
            Button {
                next = true
            } label: {
                Image(systemName: "plus")
                    .font(.system(size: 15))
                    .foregroundStyle(Color(hex: "51A2FF"))
                Text("시나리오 제작")
                    .font(.pretendard(.semibold, size: 14))
            }
            .padding(.top,20)
            .padding(.trailing,20)
            .padding(.bottom,10)
        }
    }

    private func scenarioList(_ scale: GeometryProxy) -> some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.scenario, id: \.id) { newScenario in
                    scenarioRow(newScenario, scale)
                }
            }
        }
    }

    private func scenarioRow(_ newScenario: ScenarioModel, _ scale: GeometryProxy) -> some View {
        Button {
            selectedScenarioId = newScenario.id
            alertOn = true
        } label: {
            HStack(spacing: 10) {
                AsyncImage(url: URL(string: newScenario.profile_url)) { image in
                    image.resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .frame(width: 80, height: 80)
                        .padding(.leading, -12)
                } placeholder: {
                    Image(systemName: "person.crop.circle.fill")
                        .foregroundColor(Color(hex: "C6C9CB"))
                        .font(.system(size: 60))
                }
                
                VStack(alignment: .leading,spacing: 0) {
                    Text(newScenario.name)
                        .font(.pretendard(.semibold, size: 18))
                    Text(newScenario.content)
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
    ScenarioView(viewModel: ScenarioViewModel())
}
