// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./Debt.sol";
import "./Tokenable.sol";
import "./hts-precompile/HederaTokenService.sol";
import "./hts-precompile/HederaResponseCodes.sol";

contract Remittable is Debt, Tokenable {
    address public remittanceTokenId;
    int64 public availableRemittanceAmount;

    modifier onlyEligiblePaymentRemitees() {
        require(
            msg.sender == adminId || msg.sender == investorId,
            "Only Administrator or Investor can call this function"
        );
        _;
    }

    constructor() {
        availableRemittanceAmount = 0;
    }

    // Setters
    function setAvailableRemittanceAmount(
        int64 newAvailableRemittanceAmount
    ) external onlyAdmin {
        availableRemittanceAmount = newAvailableRemittanceAmount;
    }

    function setRemittanceTokenId(
        address newRemittanceTokenId
    ) external onlyAdmin {
        remittanceTokenId = newRemittanceTokenId;
    }

    // Remittance functions
    // Optionally allow servicer to dedicate add remittance payments that investor can collect at their discretion
    function addEligibleRemittance(
        address tokenToRemit,
        int64 amountToRemit
    ) external onlyAdminOrServicer {
        if (tokenToRemit != remittanceTokenId) {
            revert("Invalid Remittance Token!");
        }

        if (
            uint256(uint64(amountToRemit)) >
            IERC20(remittanceTokenId).balanceOf(address(msg.sender))
        ) {
            revert("Insufficient Balance for Remittance Token");
        }

        availableRemittanceAmount = availableRemittanceAmount + amountToRemit;

        int response = HederaTokenService.transferToken(
            remittanceTokenId,
            msg.sender,
            address(this),
            amountToRemit
        );

        if (response != HederaResponseCodes.SUCCESS) {
            revert("Remittance Failed");
        }
    }

    // Optionally allow investor to claim any remittances that are available
    function claimRemittance(
        address tokenToClaim,
        int64 amountToClaim
    ) external onlyEligiblePaymentRemitees {
        if (tokenToClaim != remittanceTokenId) {
            revert("Invalid Remittance Token!");
        }

        if (
            uint256(uint64(amountToClaim)) >
            IERC20(remittanceTokenId).balanceOf(address(this))
        ) {
            revert("Insufficient Balance for Remittance Token");
        }

        if (amountToClaim > availableRemittanceAmount) {
            revert("Insufficient Balance for Payment Token");
        }

        availableRemittanceAmount = availableRemittanceAmount - amountToClaim;

        int response = HederaTokenService.transferToken(
            remittanceTokenId,
            address(this),
            msg.sender,
            amountToClaim
        );

        if (response != HederaResponseCodes.SUCCESS) {
            revert("Remittance Failed");
        }
    }
}
