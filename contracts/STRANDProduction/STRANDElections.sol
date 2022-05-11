// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "./STRANDCore.sol";

contract STRANDElections {
    enum ApplicationState { InProgress, Refused, Accepted }
    struct Application {
        address submittedBy;
        address nominee;
        uint32 forRole;
        string title;
        string text;
        string[] contactAddresses;
        ApplicationState state;
        uint submissionTimestamp;
        uint decisionTimestamp;
    }
    mapping(uint32 => Application) private _applications;
    uint32 _applicationsCounter = 0;

    event NewApplication(uint32 indexed applicationNumber, address user, uint32 role, string title, string text);
    event ApplicationRefused(uint32 indexed applicationNumber, string reason);
    event ApplicationAccepted(uint32 indexed applicationNumber);

    function getApplication(uint32 applicationNumber) public view returns (Application memory) {
        return _applications[applicationNumber];
    }
    function submitApplication(address user, uint32 role, string memory title, string memory text, string[] memory contactAddresses) public returns (uint32) {
        _applicationsCounter++;
        uint32 applicationNumber = _applicationsCounter;
        _applications[applicationNumber] = Application(msg.sender, user, role, title, text, contactAddresses, ApplicationState.InProgress, STRANDCore.getCurrentTimestamp(), 0);
        emit NewApplication(applicationNumber, user, role, title, text);
        return applicationNumber;
    }
    function refuseApplication(uint32 applicationNumber, string memory reason) public {
        _applications[applicationNumber].state = ApplicationState.Refused;
        _applications[applicationNumber].decisionTimestamp = STRANDCore.getCurrentTimestamp();
        emit ApplicationRefused(applicationNumber, reason);
    }
    function acceptApplication(uint32 applicationNumber) public {
        _applications[applicationNumber].state = ApplicationState.Accepted;
        _applications[applicationNumber].decisionTimestamp = STRANDCore.getCurrentTimestamp();
        emit ApplicationAccepted(applicationNumber);
    }
}