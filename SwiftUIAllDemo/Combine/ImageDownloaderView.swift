//
//  ImageDownloaderView.swift
//  SwiftUIAllDemo
//
//  Created by ak on 2022/10/9.
//

import SwiftUI
import Combine
enum ImageDownloadError: Error {
    case badUrl
    case badContent
    case other(Error)
    
    static func map(_ err: Error) -> ImageDownloadError {
        return (err as? ImageDownloadError) ?? .other(err)
    }
}

class ImageDownloader {
    static let shared = ImageDownloader()
    
    func get(url: String) -> AnyPublisher<String, Error> {
        return URLSession.shared.dataTaskPublisher(for: URL(string: url)!)
            .tryMap { (data: Data, response: URLResponse) in
                print(data, response)
                return String(data: data, encoding: .utf8) ?? "none"
            }
            .eraseToAnyPublisher()
    }
    
    func download(url: String) -> AnyPublisher<UIImage, Error> {
        return URLSession.shared.dataTaskPublisher(for: URL(string: url)!)
            .tryMap { (data: Data, response: URLResponse) -> Data in
                guard let resp = response as? HTTPURLResponse, resp.statusCode == 200 else {
                    throw ImageDownloadError.badUrl
                }
                return data
            }
            .tryMap({ data in
                guard let image = UIImage(data: data) else {
                    throw ImageDownloadError.badContent
                }
                return image
            })
            .mapError({ err in
//                return ImageDownloadError.other(err)
                //or
                ImageDownloadError.map(err)
            })
            .eraseToAnyPublisher()
    }
    
}

struct ImageDownloaderView: View {
    @State var store = Set<AnyCancellable>()
    @State var image: UIImage? = nil
    var body: some View {
        HStack{
            Image(uiImage: image ?? UIImage(named: "dog")!)
                .resizable()
                .frame(width: 180, height: 180)
                
            
            Text("Hello, World!").onAppear {
                ImageDownloader.shared.get(url: "https://www.baidu.com")
                    .sink { e in
                        print(e)
                    } receiveValue: { d in
                        print(d)
                    }
                    .store(in: &store)
                
                ImageDownloader.shared.download(url: "https://wx3.sinaimg.cn/mw690/a716fd45ly1gcqxnzw677j20u00u077i.jpg")
                    .sink { e in
                        print(e)
                    } receiveValue: { img in
                        print(img)
                        self.image = img
                    }
                    .store(in: &store)

            }
        }
       
    }
}

struct ImageDownloaderView_Previews: PreviewProvider {
    static var previews: some View {
        ImageDownloaderView()
    }
}
