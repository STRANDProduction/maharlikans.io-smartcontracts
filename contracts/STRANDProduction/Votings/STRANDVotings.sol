// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

contract STRANDVotings {
    struct Voting {
        uint256 id;
        uint64[] voterEntityIds;
    }
    struct Vote {
        address voter;
        uint256 votingPower;

    }
    struct VoterEntities {
        uint64 entityId;
        string title;
        string description;

    }

    //mapping(address => )
}
