// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "../STRANDInformationToken.sol";
import "../STRANDBase.sol";

contract STRANDVotingCommittee is STRANDBase {

    constructor(string memory title) {
        _title = title;
    }

    struct VotingCommitteeGroup {
        string title;
        ISTRANDInformationToken[] descriptiveTokens;
        VotingCommitteeGroupMember[] members;
    }
    struct VotingCommitteeGroupMember {
        address member;
        string title;
        ISTRANDInformationToken[] descriptiveTokens;
    }

    string private _title;
    ISTRANDInformationToken[] private _descriptiveTokens;
    mapping(uint32 => VotingCommitteeGroup) private _groups;
    uint32 private _votingCommitteeGroupCounter;

    uint8 private _groups_lock;
    uint8 private _groupMembers_lock;

    // -- MANAGE GROUPS ---------------------------------------------------------------------------------------------------------------------------------------
    function addGroup(string memory title) public lock(_groups_lock) returns (VotingCommitteeGroup memory) {
        require(_votingCommitteeGroupCounter < type(uint32).max, "Maximum amount of groups reached");
        uint32 groupId = ++_votingCommitteeGroupCounter;
        ISTRANDInformationToken[] memory descriptiveTokens = new ISTRANDInformationToken[](0);
        VotingCommitteeGroupMember[] memory members = new VotingCommitteeGroupMember[](0);
        VotingCommitteeGroup memory group = VotingCommitteeGroup(title, descriptiveTokens, members);
        _groups[groupId] = group;
        return group;
    }
    function removeGroup(uint32 id) public lock(_groups_lock) {
        delete _groups[id];
    }
    function getGroup(uint32 id) public view lock(_groups_lock) returns (VotingCommitteeGroup memory) {
        return _groups[id];
    }
    function _getGroup(uint32 id) private view lock(_groups_lock) returns (VotingCommitteeGroup storage) {
        return _groups[id];
    }
    // -- MANAGE GROUP MEMBERS --------------------------------------------------------------------------------------------------------------------------------
    function addGroupMember(uint32 groupId, address member, string memory title) public lock(_groupMembers_lock) {
        VotingCommitteeGroup storage group = _getGroup(groupId);
        VotingCommitteeGroupMember[] storage members = group.members;
        require(members.length < type(uint).max, "Maximum amount of members in this group reached");
        ISTRANDInformationToken[] memory descriptiveTokens = new ISTRANDInformationToken[](0);
        VotingCommitteeGroupMember memory newMember = VotingCommitteeGroupMember(member, title, descriptiveTokens);
        members.push(newMember);
    }
    function removeGroupMember(uint32 groupId, address member) public lock(_groupMembers_lock) {
        VotingCommitteeGroup storage group = _getGroup(groupId);
        VotingCommitteeGroupMember[] storage members = group.members;
        int memberIndex = _indexOfMember(members, member);
        require(memberIndex >= 0, "Member not found in group");
        _removeArrayItem(members, uint(memberIndex));
    }
    function removeMemberInAllGroups(address member) public lock(_groupMembers_lock) {
        uint32 countGroups = _votingCommitteeGroupCounter;
        for(uint32 i_group = 0; i_group < countGroups; i_group++) {
            VotingCommitteeGroup storage group = _getGroup(i_group);
            VotingCommitteeGroupMember[] storage members = group.members;
            int index = _indexOfMember(_groups[i_group].members, member);
            if(index >= 0) {
                _removeArrayItem(members, uint(index));
            }
        }
    }
    function _indexOfMember(VotingCommitteeGroupMember[] storage array, address member) private view returns (int) {
        int ret = -1;
        for(uint i = 0; i < array.length; i++) {
            if(array[i].member == member) {
                ret = int(i);
                break;
            }
        }
        return ret;
    }
    function _removeArrayItem(VotingCommitteeGroupMember[] storage array, uint index) private {
        require(index < array.length, "Index outside bounds");
        for(uint i = index; i < array.length - 1; i++) {
            array[i] = array[i-1];
        }
        array.pop();
    }
}
