import SwiftUI

struct TaskExampleView: View {
    let httpService: HttpService = HttpService()
    @State private var dogImage: UIImage?
    @State private var dogImageList: Array<UIImage> = []
    var columnConfig: Array<GridItem> =
    Array(repeating: .init(.flexible()), count: 4)
    let backScreen: () -> Void
    
    var body: some View {
        VStack {
            if self.dogImage != nil {
                Image(uiImage: self.dogImage!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                Text("Carregando")
            }
            ScrollView {
                LazyVGrid(columns: columnConfig) {
                    ForEach((0..<self.dogImageList.count), id: \.self) { id in
                        if self.dogImageList.isEmpty == false {
                            Image(uiImage: self.dogImageList[id])
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                    }
                }.font(.largeTitle)
            }
            Button("Reload") {
                Task {
                    self.dogImage = nil
                    self.dogImageList = []
                    self.dogImage = try? await self.httpService.fetchDogImage()
                    self.dogImageList = try! await self.httpService.fetchDogImageList()
                }
            }
            .task {
                self.dogImage = try? await self.httpService.fetchDogImage()
                self.dogImageList = try! await self.httpService.fetchDogImageList()
            }
        }
        .navigationTitle("Task Example")
        .navigationBarItems(leading: Button("Voltar") {
            backScreen()
        })
    }
}

struct TaskExampleView_Previews: PreviewProvider {
    static var previews: some View {
        TaskExampleView {
            
        }
    }
}
