// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./Debt.sol";
import "./hts-precompile/HederaTokenService.sol";
import "./hts-precompile/HederaResponseCodes.sol";

contract Tokenable is FinancialInstrument, HederaTokenService {
    constructor() {}

    function tokenAssociateContract(address tokenAddress) external onlyAdmin {
        int response = HederaTokenService.associateToken(
            address(this),
            tokenAddress
        );

        if (response != HederaResponseCodes.SUCCESS) {
            revert("Associate Failed");
        }
    }

    function tokenDissociateContract(address tokenAddress) external onlyAdmin {
        int response = HederaTokenService.dissociateToken(
            address(this),
            tokenAddress
        );

        if (response != HederaResponseCodes.SUCCESS) {
            revert("Dissociate Failed");
        }
    }

    function tokenTransfer(
        address tokenId,
        address fromAccountId,
        address toAccountId,
        int64 tokenAmount
    ) external onlyAdmin {
        int response = HederaTokenService.transferToken(
            tokenId,
            fromAccountId,
            toAccountId,
            tokenAmount
        );

        if (response != HederaResponseCodes.SUCCESS) {
            revert("Transfer Failed");
        }
    }
}
