// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./hts-precompile/HederaTokenService.sol";
import "./hts-precompile/HederaResponseCodes.sol";

contract MortgageLoan is HederaTokenService {

    address private _collateralAddress;

    address private _oEscrowTokenAddress;
    address private _oFeeTokenAddress;    
    address private _oInterestTokenAddress;    
    address private _oPrincipalTokenAddress;
    address private _oPrincipalNiTokenAddress;

    address private _pEscrowTokenAddress;
    address private _pFeeTokenAddress;
    address private _pInterestTokenAddress;
    address private _pPrepayTokenAddress;    
    address private _pPrincipalTokenAddress;
    address private _pPrincipalNiTokenAddress;

    address private _lEscrowTokenAddress;
    address private _lFeeTokenAddress;
    address private _lInterestTokenAddress;
    address private _lPrincipalTokenAddress;
    address private _lPrincipalNiTokenAddress;

    function getBalanceOf(address tokenAddress) public view returns (uint256) {
        return IERC20(tokenAddress).balanceOf(address(this));
    }

    function getOutstandingPrincipalBalance() public view returns (uint256) {
        return this.getBalanceOf(this._oPrincipalTokenAddress);
    }
    
    function tokenAssociate(address sender, address tokenAddress) external {
        int response = HederaTokenService.associateToken(sender, tokenAddress);

        if (response != HederaResponseCodes.SUCCESS) {
            revert ("Associate Failed");
        }
    }

    function tokenTransfer(address tokenId, address fromAccountId , address toAccountId , int64 tokenAmount) external {
        int response = HederaTokenService.transferToken(tokenId, fromAccountId, toAccountId, tokenAmount);

        if (response != HederaResponseCodes.SUCCESS) {
            revert ("Transfer Failed");
        }
    }

    function tokenDissociate(address sender, address tokenAddress) external {
        int response = HederaTokenService.dissociateToken(sender, tokenAddress);

        if (response != HederaResponseCodes.SUCCESS) {
            revert ("Dissociate Failed");
        }
    }
}

