//
//  DataTaskView.swift
//  SwiftUIWithMVVM
//
//  Created by Jerry Uhm on 2023/02/20.
//

import SwiftUI

struct DataTaskView: View {
    @StateObject var viewModel = DataTaskViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.posts) { post in
                    VStack(alignment: .leading, spacing: 15) {
                        Text(post.title)
                            .font(Font.title.bold())
                        Text(post.body)
                            .foregroundColor(Color(UIColor.systemGray2))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                }
            }
            .navigationBarTitle("Data Task")
            .listStyle(PlainListStyle())
        }
        .onAppear {
            if (viewModel.posts.count == 0) {
                viewModel.getPosts()
            }
        }
    }
}

struct DataTaskView_Previews: PreviewProvider {
    static var previews: some View {
        DataTaskView()
    }
}
