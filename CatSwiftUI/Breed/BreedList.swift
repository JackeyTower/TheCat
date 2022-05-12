//
//  BreedList.swift
//  CatSwiftUI
//
//  Created by macvm on 2022/5/2.
//

import SwiftUI
import Combine

//种类列表视图
struct BreedList: View {
    
    @ObservedObject var currentData=BreedListViewModel()
    @State var page:Int=1
    
    var body: some View {
        VStack{
            HStack{
                VStack{
                    Button("-"){
                        self.page=self.page-1
                        currentData.fetchBreeds(page: self.page)
                    }
                }
                VStack{
                    Button("+"){
                        self.page=self.page+1
                        currentData.fetchBreeds(page: self.page)
                    }
                }

            }
            Text("Page \(self.page)")
            NavigationView{
                List(currentData.breedDataList,id:\.id){breed in
                    NavigationLink(destination:
                                    BreedDetail(breed: breed)){
                        BreedRow(breed:breed)
                    }
                }
            }
        }
    }
}


struct BreedList_Previews: PreviewProvider {
    static var previews: some View {
        BreedList()
    }
}
