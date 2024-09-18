// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract PokeDIO is ERC721 {

    struct Pokemon {

        string nome;
        uint level;
        string img;
    }

    Pokemon[] public pokemons;
    address public gameOwner;

    constructor () ERC721("PokeDIO", "PKD") {
        gameOwner = msg.sender;
    }

    modifier onlyOwnerOf(uint _monsterId) {
        require(ownerOf(_monsterId) == msg.sender, "Apenas o dono do monstro");
        _;
    }

    function battle(uint _attackingPorkemon, uint _defendingPokemon) public  onlyOwnerOf(_attackingPorkemon) {
        Pokemon storage attacker = pokemons[_attackingPorkemon];
        Pokemon storage defender = pokemons[_defendingPokemon];

        if(attacker.level > defender.level) {
            attacker.level += 2;
            defender.level += 1;
        } else {
            attacker.level += 1;
            defender.level += 2;
        }
    }

    function createNewPokemon(string memory _name, address _to, string memory _img) public {
        require(msg.sender == gameOwner, "Apenas o dono do monstro");
        uint id = pokemons.length;
        pokemons.push(Pokemon(_name, 1, _img));
        _safeMint(_to, id);
        
    }

}
