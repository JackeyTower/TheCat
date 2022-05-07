//
//  CatImageView.swift
//  CatSwiftUI
//
//  Created by macvm on 2022/5/4.
//

import SwiftUI

//随机猫图片视图
struct RandomCatImageView: View {
    @ObservedObject var catImageViewModel=CatImageViewModel()
    
    var body: some View {
        VStack{
            Button("Random Cat"){
                catImageViewModel.fetchRandomCatImage()
                do{
                    var fateCatBreed=try FateCatBreedDataHelper.findFateBreedByBreedId(breedId: catImageViewModel.catImage.breedId)
                    if fateCatBreed == nil {
                        try FateCatBreedDataHelper.insert(item: FateCatBreed(
                            id:catImageViewModel.catImage.breedId
                            ,breedName: catImageViewModel.catImage.breedName
                            ,times: 1))
                    }else{
                        var times=fateCatBreed?.times
                        times=times!+1
                        do{
                            try FateCatBreedDataHelper.delete(item: fateCatBreed!)
                            fateCatBreed?.times=times!
                            try FateCatBreedDataHelper.insert(item:fateCatBreed!)
                        }catch _{
                            
                        }
                    }
                    

                }catch _{
                
                }
            }
            CatImageView(imageUrl: catImageViewModel.catImage.imageURL)
            Button("Collect It"){
                do{
                    try SQLiteDataSource.sharedInstance.createTables()
                } catch _{
                    
                }
                do{
                    var res=try CatImageDataHelper.find(findId: catImageViewModel.catImage.id)
                    if res == nil {
                        try! CatImageDataHelper.insert(item: CollectedCatImage(id:catImageViewModel.catImage.id,url:catImageViewModel.catImage.imageURL))
                    }
                }catch _{
                    
                }
            }
            Button("Vote It"){
                do{
                    try SQLiteDataSource.sharedInstance.createTables()
                } catch _{
                    
                }
                do{
                    var res=try VoteCatImageDataHelper.find(findId: catImageViewModel.catImage.id)
                    if res == nil {
                        try! VoteCatImageDataHelper.insert(item: VotedCatImage(id:catImageViewModel.catImage.id,url:catImageViewModel.catImage.imageURL))
                    }
                }catch _{
                    
                }
            }
        }
    }
    
    func voteForCat(){
        
    }
}

struct CatImageView_Previews: PreviewProvider {
    static var previews: some View {
        RandomCatImageView()
    }
}
