// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "./STRANDCore.sol";

contract STRANDPolls {
    enum PollState { Planned, Started, Finished }
    struct Poll {
        uint32 pollNumber;
        address createdBy;
        uint32 pollType;
        string title;
        string text;
        uint startDate;
        uint endDate;
        uint creationDate;
    }
    mapping(uint32 => Poll) private _polls;
    uint32 private _pollCounter = 0;

    event NewPoll(uint32 indexed pollNumber, uint32 pollType, string title, string text, uint startDate, uint endDate);

    function getPoll(uint32 pollNumber) public view returns (Poll memory) {
        return _polls[pollNumber];
    }
    function createNewPoll(uint32 pollType, string memory title, string memory text, uint startDate, uint endDate) public returns (uint32) {
        _pollCounter++;
        uint32 pollNumber = _pollCounter;
        _polls[pollNumber] = Poll(pollNumber, msg.sender, pollType, title, text, startDate, endDate, STRANDCore.getCurrentTimestamp());
        emit NewPoll(pollNumber, pollType, title, text, startDate, endDate);
        return pollNumber;
    }
}