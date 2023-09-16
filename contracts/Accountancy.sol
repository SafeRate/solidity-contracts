// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./Debt.sol";
import "./Tokenable.sol";
import "./hts-precompile/HederaTokenService.sol";
import "./hts-precompile/HederaResponseCodes.sol";

contract Accountancy is Debt, Tokenable {
    modifier onlyAccountancy() {
        require(
            msg.sender == adminId || msg.sender == servicerId,
            "Only Admin or Servicer can call this function"
        );
        _;
    }

    constructor() {}

    function accountancyAddTokenAmount(
        address accountingTokenToUse,
        int64 amountToAdd
    ) external onlyAccountancy {
        if (
            uint256(uint64(amountToAdd)) >
            IERC20(accountingTokenToUse).balanceOf(msg.sender)
        ) {
            revert("Insufficient Balance");
        }

        int response = HederaTokenService.transferToken(
            accountingTokenToUse,
            msg.sender,
            address(this),
            amountToAdd
        );

        if (response != HederaResponseCodes.SUCCESS) {
            revert("Transfer Failed");
        }
    }

    function accountancyRemoveTokenAmount(
        address accountingTokenToUse,
        int64 amountToRemove
    ) external onlyAccountancy {
        if (
            uint256(uint64(amountToRemove)) >
            IERC20(accountingTokenToUse).balanceOf(address(this))
        ) {
            revert("Insufficient Balance");
        }

        int response = HederaTokenService.transferToken(
            accountingTokenToUse,
            address(this),
            msg.sender,
            amountToRemove
        );

        if (response != HederaResponseCodes.SUCCESS) {
            revert("Transfer Failed");
        }
    }
}
