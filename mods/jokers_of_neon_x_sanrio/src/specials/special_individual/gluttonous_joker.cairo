#[dojo::contract]
pub mod special_gluttonous_joker {
    use jokers_of_neon_classic::specials::specials::SPECIAL_GLUTTONOUS_JOKER_ID;
    use jokers_of_neon_lib::interfaces::individual::ISpecialIndividual;
    use jokers_of_neon_lib::models::data::card::{Card, Suit};
    use jokers_of_neon_lib::models::special_type::SpecialType;

    #[abi(embed_v0)]
    impl SpecialGluttonousJokerImpl of ISpecialIndividual<ContractState> {
        fn condition(ref self: ContractState, card: Card) -> bool {
            card.suit == Suit::Clubs
        }

        fn execute(ref self: ContractState) -> (i32, i32, i32) {
            (0, 0, 100)
        }

        fn get_id(ref self: ContractState) -> u32 {
            SPECIAL_GLUTTONOUS_JOKER_ID
        }

        fn get_type(ref self: ContractState) -> SpecialType {
            SpecialType::Individual
        }
    }
}
