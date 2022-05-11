// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

contract STRANDRoles {
    struct Role {
        uint32 Id;
        string Name;
        string Description;
    }
    mapping(uint32 => Role) private _roles;
    mapping(address => uint32[]) internal AssignedRoles;
    uint32 private _highestRoleId = 0;

    function addRole(uint32 id, string memory name, string memory description) public {
        _roles[id] = Role(id, name, description);
    }
    function addRole(string memory name, string memory description) public returns (uint32) {
        _highestRoleId++;
        uint32 roleId = _highestRoleId;
        addRole(roleId, name, description);
        return roleId;
    }
    function assignRole(address user, uint32 role) public {
        AssignedRoles[user].push(role);
    }
    function unassignRole(address user, uint32 role) public {
        uint32[] memory newRoles = new uint32[](AssignedRoles[user].length - 1);
        uint32 counter = 0;
        for(uint i = 0; i < AssignedRoles[user].length; i++) {
            if(AssignedRoles[user][i] != role) {
                newRoles[counter] = AssignedRoles[user][i];
                counter++;
            }
        }
        AssignedRoles[user] = newRoles;
    }
    function removeRole(uint32 id) public {
        delete _roles[id];
    }
    function hasRoleAssigned(address user, uint32 role) public view returns (bool) {
        bool ret = false;
        for(uint i = 0; i < AssignedRoles[user].length; i++) {
            if(AssignedRoles[user][i] == role) {
                ret = true;
                break;
            }
        }
        return ret;
    }
}
