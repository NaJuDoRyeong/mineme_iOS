//
//  StoryHomeViewReactor.swift
//  Story
//
//  Created by 김민령 on 2023/11/07.
//

import Foundation
import ReactorKit

struct StoryHomeViewState {
    var postList: [PostPreview] = []
    var postIsEmpty: Bool = true
}

enum StoryHomeViewAction {
    case initialize
}

final class StoryHomeViewReactor: Reactor {
    typealias Action = StoryHomeViewAction
    typealias State = StoryHomeViewState
    
    var initialState: StoryHomeViewState
    private let useCase: GetPostUseCase
    
    enum Mutation {
        case setPostList([PostPreview])
        case setPostIsEmpty(Bool)
    }
    
    init(useCase: GetPostUseCase) {
        self.initialState = .init()
        self.useCase = useCase
    }
    
    func mutate(action: StoryHomeViewAction) -> Observable<Mutation> {
        switch action {
        case .initialize:
            return getPost()
        }
    }
    
    func reduce(state: StoryHomeViewState, mutation: Mutation) -> StoryHomeViewState {
        var newState = state
        
        switch mutation {
        case .setPostList(let array):
            newState.postList = array
        case .setPostIsEmpty(let bool):
            newState.postIsEmpty = bool
        }
        
        return newState
    }
    
    func getPost() -> Observable<Mutation> {
        useCase.fetchPost()
            .flatMap { postList -> Observable<Mutation> in
                    .concat(.just(.setPostList(postList)),
                            .just(.setPostIsEmpty(postList.isEmpty)))
            }
    }
}
