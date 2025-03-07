import SwiftUI

struct ContactCard: View {
    let height: CGFloat
    var body: some View {
        GeometryReader { scale in
            VStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: scale.size.width * 1,height: height)//499
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
                                ContactUserList(users: ["이상은", "김강연", "이기찬", "박민주"], limit: 4).padding(.bottom,7)
                            
                            Spacer()
                        }
                    }
            }
            .frame(width: scale.size.width,height: 526)//526
        }
    }
}


