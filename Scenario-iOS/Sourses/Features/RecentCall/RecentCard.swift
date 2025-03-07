
import SwiftUI

struct RecentCard: View {
    var body: some View {
        GeometryReader { scale in
            VStack {
                Rectangle()
                    .frame(width: scale.size.width * 1,height: 499)
                    .foregroundColor(.clear)
                    .overlay {
                        VStack(spacing:0) {
                            HStack {
                                RecentCallPickerView()
                                    .padding(.bottom,13)
                                Spacer()
                            }
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.white)
                                .overlay {
                                    VStack {
                                        HStack {
                                            Text("연락처")
                                                .font(.pretendard(.semibold, size: 16))
                                                .padding(20)
                                                .foregroundStyle(Color(hex: "2B7FFF"))
                                            Spacer()
                                        }
                                            ContactUserList(users: ["이상은", "김강연", "이기찬", "박민주"], limit: 1).padding(.bottom,7)
                                            
                                        Spacer()
                                    }
                                }
                        }
                    }
            }
            .frame(width: scale.size.width,height: 526)
            
        }
    }
}

#Preview {
    RecentCard()
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
