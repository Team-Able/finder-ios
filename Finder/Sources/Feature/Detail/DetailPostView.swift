//
//  DetailPost.swift
//  Finder
//
//  Created by dgsw30 on 12/13/24.
//

import SwiftUI

struct DetailPostView: View {
    @State var draw: Bool = false
    @State private var toComment = false
    @State private var longitude: Double
    @State private var latitude: Double
    
    let getPost: DetailPostModel
    
    init(getPost: DetailPostModel) {
        _longitude = State(initialValue: getPost.location.longitude)
        _latitude = State(initialValue: getPost.location.latitude)
        self.getPost = getPost
    }

    var body: some View {
        ZStack {
            KakaoMapView(draw: $draw, longitude: $longitude, latitude: $latitude)
                .onAppear(perform: {
                    self.draw = true
                }).onDisappear(perform: {
                    self.draw = false
                })
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            ZStack {
                VStack {
                    Spacer()
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: 393, height: 455)
                        .cornerRadius(40)
                }
                VStack {
                    if let imageURL = URL(string: getPost.imageUrl) {
                        AsyncImage(url: imageURL) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .cornerRadius(10)
                                .frame(width: 330, height: 171)
                        } placeholder: {
                            ProgressView()
                        }
                        .padding(.top, 320)
                    }
                    
                    HStack {
                        Text(getPost.title)
                            .font(.bold(18))
                            .padding(.leading, 36)
                        Spacer()
                        Text(getPost.createdAt)
                            .font(.regular(14))
                            .foregroundStyle(.graycolor)
                            .padding(.trailing, 36)
                    }
                    .padding(.vertical, 20)
                    
                    VStack(alignment: .leading) {
                        Text(getPost.content)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 36)
                            .font(.regular(15))
                    }
                    
                    VStack {
                        Button {
                            toComment = true
                        } label: {
                            Text("댓글달기")
                                .font(.regular(18))
                                .foregroundStyle(.white)
                                .frame(width: 330, height: 50)
                                .background(.primary500)
                                .cornerRadius(10)
                                .padding(.top, 45)
                        }
                    }
                }
                .padding(.top, 30)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .backButton()
        .navigationDestination(isPresented: $toComment) {
            CommentView(id: .constant(getPost.id))
        }
    }
}
