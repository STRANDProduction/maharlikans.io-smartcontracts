// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "./STRANDPolls.sol";
import "./STRANDRoles.sol";

abstract contract STRANDGovernmentalToken {
    uint32 constant ROLE_OWNER = 1;
    uint32 constant ROLE_ROLE_MANAGEMENT = 2;
    uint32 constant ROLE_ELECTION_COMMITTEE = 3;
    uint32 constant ROLE_VOTING_COMMITTEE = 4;
    address internal immutable ContractCreator;
    uint256 internal immutable AbsoluteInitialSupply;
    uint8 internal immutable Decimals;
    bool internal immutable CanBurn;
    bool internal immutable CanMint;
    STRANDRoles private Roles;
    STRANDPolls private Voting;
    constructor(uint256 absoluteInitialSupply, uint8 decimals, bool canBurn, bool canMint) {
        ContractCreator = msg.sender;
        AbsoluteInitialSupply = absoluteInitialSupply;
        Decimals = decimals;
        CanBurn = canBurn;
        CanMint = canMint;
        Voting = new STRANDPolls();
        Roles = new STRANDRoles();
        setDefaultRoles();
    }
    function setDefaultRoles() private {
        Roles.addRole(ROLE_OWNER, "OWNER", "Contract owners");
        Roles.addRole(ROLE_ROLE_MANAGEMENT, "ROLE_MANAGEMENT", "Role management");
        Roles.addRole(ROLE_ELECTION_COMMITTEE, "ELECTION_COMMITTEE", "Election committee");
        Roles.addRole(ROLE_VOTING_COMMITTEE, "VOTING_COMMITTEE", "Voting committee");
        Roles.assignRole(ContractCreator, ROLE_OWNER);
        Roles.assignRole(ContractCreator, ROLE_ROLE_MANAGEMENT);
    }
    function initialSupply() internal view returns (uint256) {
        return AbsoluteInitialSupply * 10 ** Decimals;
    }

    modifier roleOwnerCommittee{
        require(Roles.hasRoleAssigned(msg.sender, ROLE_OWNER));
        _;
    }
    modifier roleRoleManagement{
        require(Roles.hasRoleAssigned(msg.sender, ROLE_ROLE_MANAGEMENT));
        _;
    }
    modifier roleElectionCommittee{
        require(Roles.hasRoleAssigned(msg.sender, ROLE_ELECTION_COMMITTEE));
        _;
    }
    modifier roleVotingCommittee{
        require(Roles.hasRoleAssigned(msg.sender, ROLE_VOTING_COMMITTEE));
        _;
    }

    function getRoles() public view roleRoleManagement returns (STRANDRoles) {
        return Roles;
    }
    function getPolls() public view roleVotingCommittee returns (STRANDPolls) {
        return Voting;
    }
}