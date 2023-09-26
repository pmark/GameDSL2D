import OctopusKit
import Combine

public class Game: BaseConstruct, ObservableObject {
    private(set) lazy var coordinator: DSLGameCoordinator = {
        return DSLGameCoordinator(states: self.gameStates)
    }()
    
    var scenes: [Scene] {
        children(ofType: Scene.self)
    }
    
    var gameStates: [GameState] {
        self.children(ofType: GameState.self)
    }
}
