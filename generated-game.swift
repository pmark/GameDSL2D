let game = Game {
    Title("Energy Monster")
    
    Level(named: "Tutorial") {
        Scenario(named: "Learn the basics") {
            Entity(named: "Player") {
                Component(MovementComponent())
                Component(ShieldComponent())
            }
            
            Entity(named: "Monster Pod") {
                Component(DormantComponent())
                Component(TriggeredComponent())
            }
            
            Entity(named: "Power-up") {
                Component(HiddenComponent())
                Component(ShieldPowerUpComponent())
                Component(SpeedBoostPowerUpComponent())
            }
            
            System(MovementComponent.self) { entity, component in
                // Update logic for player's movement
            }
            
            System(DormantComponent.self, TriggeredComponent.self) { entity, components in
                // Update logic when monster pods are dormant or triggered
            }
            
            System(ShieldPowerUpComponent.self, SpeedBoostPowerUpComponent.self) { entity, components in
                // Update logic for the power-ups
            }
        }
    }
    
    Level(named: "Level 1") {
        Scenario(named: "Navigate the maze") {
            // Define your entities and systems here...
        }
    }
    
    // Define more levels here...
    
    System(named: "Game Progression") {
        // Logic to handle game progression, difficulty increase, etc.
    }
    
    System(named: "Scoring") {
        // Logic to handle scoring and status indicators
    }
    
    System(named: "Power-up Distribution") {
        // Logic to handle power-up distribution and collection
    }
}

game.play()
