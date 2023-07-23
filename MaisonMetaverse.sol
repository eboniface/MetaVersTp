// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MaisonMetaverse is ERC721, Ownable {
    struct Maison {
        string name;
        uint256 price;
    }

    Maison[] public maisons;

    uint256 public cost;
    uint256 public maxSupply;
    uint256 public totalSupply;

    constructor(
        string memory _name, 
        string memory _symbol, 
        uint256 _cost, 
        uint256 _maxSupply
    ) ERC721(_name, _symbol) {
        cost = _cost;
        maxSupply = _maxSupply;
        totalSupply = 0;
    }

    function mint(string memory _name) public payable {
        require(totalSupply < maxSupply, "Aucune autre maison n'est disponible");
        require(msg.value >= cost, "Le montant est inferieur au cout de la maison");
        
        maisons.push(Maison(_name, msg.value));
        uint256 newMaisonId = maisons.length - 1;
        
        _safeMint(msg.sender, newMaisonId);
        totalSupply++;
    }

    function getOwnerOfMaison(uint256 _maisonId) public view returns (address) {
        return ownerOf(_maisonId);
    }

    function getPriceOfMaison(uint256 _maisonId) public view returns (uint256) {
        return maisons[_maisonId].price;
    }

    function getNameOfMaison(uint256 _maisonId) public view returns (string memory) {
        return maisons[_maisonId].name;
    }
}