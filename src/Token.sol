// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.30;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {AccessControl} from "@openzeppelin/contracts/access/AccessControl.sol";

contract Token is ERC20, Ownable, AccessControl {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    constructor(string memory _name, string memory _symbol, address _minterRole)
        ERC20(_name, _symbol)
        Ownable(msg.sender)
    {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(MINTER_ROLE, _minterRole);
    }

    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }

    function burn(address from, uint256 amount) external onlyOwner {
        _burn(from, amount);
    }

    function mintByMinter(address to, uint256 amount) external 
    onlyRole(MINTER_ROLE) {
        _mint(to, amount);
    }

    function burnByMinter(address from, uint256 amount) external 
    onlyRole(MINTER_ROLE) {
        _burn(from, amount);
    }

    function addMinter(address account) external onlyOwner {
        grantRole(MINTER_ROLE, account);
    }

    function removeMinter(address account) external onlyOwner {
        revokeRole(MINTER_ROLE, account);
    }

    function grantRoleAsOwner(bytes32 role, address account) external onlyOwner {
        grantRole(role, account);
    }

    function revokeRoleAsOwner(bytes32 role, address account) external onlyOwner {
        revokeRole(role, account);
    }
}

