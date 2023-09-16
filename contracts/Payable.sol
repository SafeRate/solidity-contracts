// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./Debt.sol";
import "./Tokenable.sol";
import "./hts-precompile/HederaTokenService.sol";
import "./hts-precompile/HederaResponseCodes.sol";

contract Payable is Debt, Tokenable {
    address public paymentTokenId;
    int64 public unprocessedPaymentAmount;

    modifier onlyEligiblePayers() {
        require(
            msg.sender == adminId ||
                msg.sender == borrowerId ||
                msg.sender == guarantorId ||
                msg.sender == insurerId,
            "Only Admin, Borrower, or Investor can call this function"
        );
        _;
    }

    constructor() {
        unprocessedPaymentAmount = 0;
    }

    // Setters
    function setPaymentTokenId(address newPaymentTokenId) external onlyAdmin {
        paymentTokenId = newPaymentTokenId;
    }

    function setUnprocessedPaymentAmount(
        int64 newUnprocessedPaymentAmount
    ) external onlyAdmin {
        unprocessedPaymentAmount = newUnprocessedPaymentAmount;
    }

    // COLLECTION: STABLECOIN PAYMENTS - enable and manage collection and remittance payments for the loan via stablecoins
    // Allow borrower to make payments via specified stablecoin
    function makeLoanPayment(
        address tokenToPay,
        int64 amountToPay
    ) external onlyEligiblePayers {
        if (tokenToPay != paymentTokenId) {
            revert("Invalid Payment Token!");
        }

        if (
            uint256(uint64(amountToPay)) >
            IERC20(paymentTokenId).balanceOf(msg.sender)
        ) {
            revert("Insufficient Balance");
        }

        unprocessedPaymentAmount = unprocessedPaymentAmount + amountToPay;

        int response = HederaTokenService.transferToken(
            paymentTokenId,
            msg.sender,
            address(this),
            amountToPay
        );

        if (response != HederaResponseCodes.SUCCESS) {
            revert("Transfer Failed");
        }
    }

    // Allow servicer to collect any payments that were made
    function processLoanPayments(
        address tokenToProcess,
        int64 amountToProcess
    ) external onlyAdminOrServicer {
        if (tokenToProcess != paymentTokenId) {
            revert("Invalid Payment Token!");
        }

        if (
            uint256(uint64(amountToProcess)) >
            IERC20(paymentTokenId).balanceOf(address(this))
        ) {
            revert("Insufficient Balance");
        }

        if (amountToProcess > unprocessedPaymentAmount) {
            revert(
                "Amount requested to process is greater than the unprocessed amount"
            );
        }

        unprocessedPaymentAmount = unprocessedPaymentAmount - amountToProcess;

        int response = HederaTokenService.transferToken(
            paymentTokenId,
            address(this),
            msg.sender,
            amountToProcess
        );

        if (response != HederaResponseCodes.SUCCESS) {
            revert("Transfer Failed");
        }
    }
}
