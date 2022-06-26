// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ERC165.sol";
import "./interfaces/IERC721.sol";
import "./libraries/Counters.sol";

contract ERC721 is ERC165, IERC721 {
    using SafeMath for uint256;
    using Counters for Counters.Counter;

    // Mapping from token id to the owner
    mapping(uint256 => address) private _tokenOwner;
    // Mapping from owner to number of owned tokens
    mapping(address => Counters.Counter) private _ownedTokensCount;
    // Mapping from token id to approved addresses
    mapping(uint256 => address) private _tokenApprovals;

    constructor() {
        _registerInterface(
            bytes4(
                keccak256("balanceOf(bytes4)") ^
                    keccak256("ownerOf(bytes4)") ^
                    keccak256("transferFrom(bytes4)")
            )
        );
    }

    function _exists(uint256 tokenId) internal view returns (bool) {
        address owner = _tokenOwner[tokenId];
        return owner != address(0);
    }

    function _mint(address to, uint256 tokenId) internal virtual {
        require(to != address(0), "ERC721: minting to a zero address");
        require(!_exists(tokenId), "ERC721: token already minted");
        _tokenOwner[tokenId] = to;
        _ownedTokensCount[to].increment();

        emit Transfer(address(0), to, tokenId);
    }

    function _transferFrom(
        address _from,
        address _to,
        uint256 _tokenId
    ) internal {
        require(_to != address(0), "ERC721: invalid to address");
        require(_exists(_tokenId), "ERC721: Token does not exist!");
        require(
            _from == ownerOf(_tokenId),
            "ERC721: from address is not the owner of this token"
        );

        _tokenOwner[_tokenId] = _to;
        _ownedTokensCount[_from].decrement();
        _ownedTokensCount[_to].increment();

        emit Transfer(_from, _to, _tokenId);
    }

    function transferFrom(
        address _from,
        address _to,
        uint256 _tokenId
    ) public {
        require(
            isApprovedOrOwner(msg.sender, _tokenId),
            "ERC721 - Error not owner or approved for this token"
        );
        _transferFrom(_from, _to, _tokenId);
    }

    function approve(address _to, uint256 _tokenId) public {
        address owner = ownerOf(_tokenId);

        require(
            _to != owner,
            "ERC721 - Error, trying to approve current owner!"
        );
        require(
            msg.sender == owner,
            "ERC721 - Error, not the current owner. Cannot approve!"
        );

        _tokenApprovals[_tokenId] = _to;
        emit Approval(owner, _to, _tokenId);
    }

    function isApprovedOrOwner(address spender, uint256 tokenId)
        internal
        view
        returns (bool)
    {
        require(_exists(tokenId), "Token does not exist");
        address owner = _tokenOwner[tokenId];
        return (spender == owner || getApproved(tokenId) == spender);
    }

    function getApproved(uint256 _tokenId) internal view returns (address) {
        require(
            _exists(_tokenId),
            "ERC721: approved query for nonexistent token"
        );
        return _tokenApprovals[_tokenId];
    }

    function balanceOf(address _owner) public view returns (uint256) {
        require(_owner != address(0), "ERC721: Owner query is not valid");
        return _ownedTokensCount[_owner].current();
    }

    function ownerOf(uint256 tokenId) public view returns (address) {
        require(_exists(tokenId), "ERC721: Token does not exist!");
        return _tokenOwner[tokenId];
    }
}
