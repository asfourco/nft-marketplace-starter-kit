// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ERC721 {

    event Transfer(
        address indexed from,
        address indexed to,
        uint256 indexed tokenId
    );

    // Mapping from token id to the owner
    mapping(uint256 => address) private _tokenOwner;
    // Mapping from owner to number of owned tokens
    mapping(address => uint256) private _OwnedTokensCount;

    function _exists(uint256 tokenId) internal view returns(bool) {
        address owner = _tokenOwner[tokenId];
        return owner != address(0);
    }

    function _mint(address to, uint256 tokenId) internal {
        require(
            to != address(0), 
            'ERC721: minting to a zero address'
        );
        require(
            !_exists(tokenId),
            'ER721: token already minted'
        );
        _tokenOwner[tokenId] = to;
        _OwnedTokensCount[to] += 1;

        emit Transfer(address(0), to, tokenId);
    }
}