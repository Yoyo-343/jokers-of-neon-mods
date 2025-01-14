#[dojo::contract]
pub mod special_plus_plays {
    use jokers_of_neon_classic::specials::specials::SPECIAL_PLUS_PLAYS_ID;
    use jokers_of_neon_lib::interfaces::game::ISpecialGameTypeSpecificType;
    use jokers_of_neon_lib::models::status::game::game::Game;

    #[abi(embed_v0)]
    impl SpecialPlusPlaysImpl of ISpecialGameTypeSpecificType<ContractState> {
        fn equip(ref self: ContractState, game: Game) -> Game {
            let mut game = game;
            game.max_hands += 1;
            game
        }

        fn unequip(ref self: ContractState, game: Game) -> Game {
            let mut game = game;
            game.max_hands -= 1;
            game
        }

        fn get_id(ref self: ContractState) -> u32 {
            SPECIAL_PLUS_PLAYS_ID
        }
    }
}
