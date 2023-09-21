
public class Game: BaseConstruct {
    var scenes: [Scene] {
        children(ofType: Scene.self)
    }
    
    var gameStates: [GameState] {
        children(ofType: GameState.self)
    }
}
