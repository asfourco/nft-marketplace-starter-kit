// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './ERC721Connector.sol';

contract Kryptobird is ERC721Connector {
    string[] public kryptobirdz;
    
    mapping(string => bool) _kryptobirdzExists;

    function mint(string memory _kryptoBird) public {
        require(
            !_kryptobirdzExists[_kryptoBird],
            'Error: kryptobird already exists'
        );
        
        kryptobirdz.push(_kryptoBird);
        
        uint _id = kryptobirdz.length - 1;
        _mint(msg.sender, _id);
        
        _kryptobirdzExists[_kryptoBird] = true;
    }
    constructor() ERC721Connector('Kryptobird', 'KBIRDZ') {}
}