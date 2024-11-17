import SwiftUI

struct CreatePlaylistView: View {
    var onCancel: (() -> Void)? // 취소 버튼 동작
    var onConfirm: (() -> Void)? // 확인 버튼 동작
    @Environment(\.dismiss) var dismiss
    @State private var isFocused: Bool = false // 텍스트 필드 포커스 상태
    @State private var text: String = "" // 입력된 텍스트를 저장
    var placeholder: String = "플레이리스트 이름을 입력해주세요"
    
    var body: some View {
        ZStack{
            Color(.clear)
            VStack (spacing: 20) {
                Spacer() // 상단 여백
                    .frame(height: 40)
                Text("플레이리스트 만들기")
                    .font(.custom(PretendardFontName.Bold, size: 28))
                    .foregroundStyle(Color.white)
                Spacer() // 상단 여백
                
                VStack {
                    // 텍스트 필드
                    
                    ZStack(alignment: .center) {
                        if text.isEmpty && !isFocused{
                            Text(placeholder)
                                .foregroundColor(.white)
                                .opacity(0.8)// 플레이스홀더 색상
                        }
                        TextField("", text: $text)
                            .padding(.bottom, 5)
                            .textFieldStyle(PlainTextFieldStyle()) // Plain 스타일로 커스터마이즈
                            .foregroundColor(.white)
                            .font(.custom(PretendardFontName.Medium, size: 20))
                            .frame(height: 40) // 고정된 높이 설정
                            .multilineTextAlignment(.center)
                            .onTapGesture {
                                isFocused = true
                            }
                            .onSubmit {
                                isFocused = false
                            }
                    }
                    .frame(height: 40)
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 22)
                Spacer() // 상단 여백
                
                HStack {
                    BasicButton(type: .cancel) {
                        dismiss() // SwiftUI 시트 닫기
                        onCancel?() // 추가 동작
                    }
                    BasicButton(type: .confirm) {
                        dismiss() // SwiftUI 시트 닫기
                        onConfirm?() // 추가 동작

                    }
                }
                .padding(.horizontal, 22)
                Spacer() // 상단 여백
                    .frame(height: 20)
            }
        }.ignoresSafeArea()
    }
}

#Preview {
    CreatePlaylistView()
        .background(Color.background)
}



