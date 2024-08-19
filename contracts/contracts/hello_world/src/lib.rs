#![no_std]
use soroban_sdk::{contract, contractimpl, Address, Env, Symbol};

#[contract]
pub struct DepositContract;

#[contractimpl]
impl DepositContract {
    pub fn deposit(env: Env, user_id: Symbol, amount: i128) {
        let user = env.current_contract_address();
        let balance = env.storage().instance().get(&user_id).unwrap_or(0);
        env.storage().instance().set(&user_id, &(balance + amount));
        env.events()
            .publish((Symbol::short("deposit"), user_id), amount);
    }

    pub fn get_balance(env: Env, user_id: Symbol) -> i128 {
        env.storage().instance().get(&user_id).unwrap_or(0)
    }
}

// CCNV3O3SIHBWRSOLO37HKLWRCOO4OX4FR3W677EMYZ3K3QBL2WEODUKM
