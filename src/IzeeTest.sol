// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {ERC721A} from "ERC721A/ERC721A.sol";
import {Ownable} from "openzeppelin/access/Ownable.sol";

error MintLimitExceeded();

contract Izeetest is ERC721A, Ownable {
    uint256 public constant MINT_LIMIT = 5;
    uint256 public constant MAX_SUPPLY = 9999;

    string public _baseTokenURI = "";

    constructor() ERC721A("Izeetest", "IZT") {}

    function mint(uint256 qty) external payable {
        if (totalSupply() < MAX_SUPPLY) revert MintLimitExceeded();
        if (qty > MINT_LIMIT) revert MintLimitExceeded();
        _mint(msg.sender, qty);
    }

    function setBaseURI(string calldata baseURI) external onlyOwner {
        _baseTokenURI = baseURI;
    }

    function _baseURI() internal view override returns (string memory) {
        return _baseTokenURI;
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        if (!_exists(tokenId)) revert URIQueryForNonexistentToken();

        string memory baseURI = _baseURI();
        return bytes(baseURI).length != 0 ? baseURI : "";
    }
}
