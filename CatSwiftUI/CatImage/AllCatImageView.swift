//
//  AllCatImageView.swift
//  CatSwiftUI
//
//  Created by macvm on 2022/5/5.
//

import SwiftUI

struct AllCatImageView: View {
    @ObservedObject var currentData=AllCatImageViewModel()
    @State var page:Int=1
    
    var body: some View {
        VStack{
            HStack{
                VStack{
                    Button("-"){
                        self.page=self.page-1
                        currentData.fetchAllCatImage(page: self.page)
                    }
                }
                VStack{
                    Button("+"){
                        self.page=self.page+1
                        currentData.fetchAllCatImage(page: self.page)
                    }
                }

            }
            Text("Page \(self.page)")
            NavigationView{
                List(currentData.catImageData,id:\.id){catImage in
//                    NavigationLink(destination:
//                                    CatImageView(breed: breed)){
//                        BreedRow(breed:breed)
//                    }
                    HStack{
                        CatImageView(imageUrl:catImage.imageURL)
                        Button("Collect It"){
                            do{
                                try SQLiteDataSource.sharedInstance.createTables()
                            } catch _{
                                
                            }
                            do {
                                var res=try CatImageDataHelper.find(findId: catImage.id)
                                if res != nil{
                                    do{
                                        try! CatImageDataHelper.insert(item: CollectedCatImage(id:catImage.id,url:catImage.imageURL))
                                    }catch _{
                                        
                                    }
                                }
                            }catch _{
                                
                            }

                        }
                    }
                }
            }
        }
    }

}

struct AllCatImageView_Previews: PreviewProvider {
    static var previews: some View {
        AllCatImageView()
    }
}
