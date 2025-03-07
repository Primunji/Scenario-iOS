import SwiftUI

struct ContactCard: View {
    let title: String
    var body: some View {
        GeometryReader { scale in
            VStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: scale.size.width * 1,height: 499)
                    .foregroundColor(.white)
                    .overlay {
                        VStack {
                            HStack {
                                Text(title)
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
            .frame(width: scale.size.width,height: 526)
        }
    }
}


