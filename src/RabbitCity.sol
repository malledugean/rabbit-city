// SPDX-License-Identifier: Apache-2.0
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.20;

import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721EnumerableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721BurnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract RabbitCity is Initializable, ERC721Upgradeable, ERC721EnumerableUpgradeable, ERC721BurnableUpgradeable, OwnableUpgradeable {
    uint256 private _nextTokenId;

    /// Rabbit data
    struct Rabbit{
        string name;
        uint level;
        uint attack;
        uint magicAttack;
        uint defense;
        uint magicDefense;
        uint hitRate;
        uint criticalHitRate;
        uint fleeRate;
        uint attackSpeed;
        uint hitPoints;
        uint spellPoints;
        uint powerATK;
        uint spellMATK;
        uint resist;
        uint magicResist;
        uint healPLUS;
        uint criticalDamageRate;
        uint attackRange;
        uint castTime;
        uint castDelay;
        uint cooldown;
        uint criticalHitShield;
        uint perfectDodge;
        uint perfectHit;
        uint weightLimit;
        uint movementSpeed;
        uint statusEffectsResistance;
        uint experience;
        address rabbitAddress;
    }

    Rabbit[] public rabbits;
    address public gameOwner;

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize(address initialOwner) initializer public {
        __ERC721_init("RabbitCity", "RBC");
        __ERC721Enumerable_init();
        __ERC721Burnable_init();
        __Ownable_init(initialOwner);
        gameOwner = msg.sender;
    }

    function _baseURI() internal pure override returns (string memory) {
        return "https://opensea.io/collection/the-rabbit-collection-3";
    }

    function safeMint(address to) public onlyOwner {
        uint256 tokenId = _nextTokenId++;
        _safeMint(to, tokenId);
    }

    // The following functions are overrides required by Solidity.

    function _update(address to, uint256 tokenId, address auth)
        internal
        override(ERC721Upgradeable, ERC721EnumerableUpgradeable)
        returns (address)
    {
        return super._update(to, tokenId, auth);
    }

    function _increaseBalance(address account, uint128 value)
        internal
        override(ERC721Upgradeable, ERC721EnumerableUpgradeable)
    {
        super._increaseBalance(account, value);
    }

    modifier onlyRabbitOwner(uint _rabbitId) {

        require(ownerOf(_rabbitId) == msg.sender,"Only the owner of the rabbit can run this function");
        _;

    }

     function battle(uint _attackingRabbit, uint _defendingRabbit) public onlyRabbitOwner(_attackingRabbit){
        Rabbit storage attacker = rabbits[_attackingRabbit];
        Rabbit storage defender = rabbits[_defendingRabbit];

        // calculate power
        uint attackerPower = attacker.attack + attacker.defense;
        uint defenderPower = defender.attack + defender.defense;

         if (attackerPower>= defenderPower) {
            attacker.experience += 2 * attacker.level;
            defender.experience += 1 * attacker.level;
        }else{
            attacker.experience += 1 * attacker.level;
            defender.experience += 2 * attacker.level;
        }

        attacker.level = attacker.experience / (10 * attacker.level);
        defender.level = defender.experience / (10 * defender.level);
    }

    function registerYourRabbit(string memory _name, address _to, address _rabbitAddress, uint _str
, uint _agi, uint _vit, uint _int, uint _dex, uint _luk, string memory _class) public {
        require(msg.sender == gameOwner, "Only game owner  may registry the Rabbits");
        uint id = rabbits.length;
        string memory name = _name;
        // to do setup calculations based on stats of rabbit
        uint level = 1;
        uint attack = 2;
        uint magicAttack = 2;
        uint defense = 2;
        uint magicDefense = 2;
        uint hitRate = 2;
        uint criticalHitRate = 2;
        uint fleeRate = 2;
        uint attackSpeed = 2;
        uint hitPoints = 2;
        uint spellPoints = 2;
        uint powerATK = 2;
        uint spellMATK = 2;
        uint resist = 2;
        uint magicResist = 2;
        uint healPLUS = 2;
        uint criticalDamageRate = 2;
        uint attackRange = 2;
        uint castTime = 2;
        uint castDelay = 2;
        uint cooldown = 2;
        uint criticalHitShield = 2;
        uint perfectDodge = 2;
        uint perfectHit = 2;
        uint weightLimit = 2;
        uint movementSpeed = 2;
        uint statusEffectsResistance = 2;
        uint experience = 0;
        address rabbitAddress = _rabbitAddress;
        rabbits.push(Rabbit(name,level,attack,magicAttack,defense,magicDefense,hitRate,criticalHitRate,fleeRate,attackSpeed,hitPoints,spellPoints,powerATK,spellMATK,resist,magicResist,healPLUS,criticalDamageRate,attackRange,castTime,castDelay,cooldown,criticalHitShield,perfectDodge,perfectHit,weightLimit,movementSpeed,statusEffectsResistance,experience,rabbitAddress));
        _safeMint(_to, id);
    }


    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721Upgradeable, ERC721EnumerableUpgradeable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
