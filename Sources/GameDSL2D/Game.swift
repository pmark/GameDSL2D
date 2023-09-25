import OctopusKit

public class Game: BaseConstruct {
    var scenes: [Scene] {
        children(ofType: Scene.self)
    }
    
    var gameStates: [GameState] {
        self.children(ofType: GameState.self)
    }
}
