// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "../../@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "../STRANDProduction/STRANDGovernmentalToken.sol";
import "../STRANDProduction/STRANDStakeable.sol";

contract Maharlikans is ERC20Burnable, STRANDGovernmentalToken, STRANDStakeable {

    uint32 private immutable ROLE_STAKING_COMMITTEE;

    constructor() ERC20("Maharlikans", "MHLKS")
                  STRANDGovernmentalToken(100000000, 18, true, true)
                  STRANDStakeable() {
        _mint(msg.sender, initialSupply());
        _setStakingReward(1 weeks, 1000);
        ROLE_STAKING_COMMITTEE = getRoles().addRole("ROLE_STAKING_COMMITTEE", "Staking committee");
    }

    function burnable() public view returns (bool) { return CanBurn; }
    function mintable() public view returns (bool) { return CanMint; }

    // -- ERC20 OVERRIDES -----------------------------------------------------------------------------------------------------------------
    function decimals() override public view returns (uint8) {
        return Decimals;
    }
    // STRAND: deploy-remove
    function _beforeTokenTransfer(address from, address to, uint256 amount) internal override {
        ERC20._beforeTokenTransfer(from, to, amount);
    }

    // -- STAKING FUNCTIONS ---------------------------------------------------------------------------------------------------------------
    modifier roleStakingCommittee {
        require(getRoles().hasRoleAssigned(msg.sender, ROLE_STAKING_COMMITTEE));
        _;
    }
    /**
    * @notice changing staking rewards. this takes immediatley effect.
    * this is limited to the members of the staking committee
     */
    function changeStakingReward(uint rewardPeriode, uint256 rewardPercentage) public roleStakingCommittee {
        _setStakingReward(rewardPeriode, rewardPercentage);
    }
    /**
    * @notice stake is used to stake a particular amount of tokens
     */
    function stake(uint256 _amount) public {
        // Make sure staker actually is good for it
        require(_amount <= balanceOf(msg.sender), "Cannot stake more than you own");
        _stake(_amount);
        // Burn the amount of tokens on the sender
        _burn(msg.sender, _amount);
    }
    /**
    * @notice withdrawStake is used to withdraw stakes from the account holder
     */
    function withdrawStake(uint256 amount, uint256 stake_index) public {
        uint256 amount_to_mint = _withdrawStake(amount, stake_index);
        // Return staked tokens to user
        _mint(msg.sender, amount_to_mint);
    }
}