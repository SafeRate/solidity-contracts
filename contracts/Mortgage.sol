// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./Debt.sol";
import "./Payable.sol";
import "./Accountancy.sol";

contract Mortgage is Debt, Accountancy, Payable {
    uint public loanNumber;
    string public loanType;
    string public nextStatementDate;
    string public occupancy;
    string public prevStatementDate;

    constructor() Debt() Accountancy() Payable() {}

    function getLoanNumber() external view returns (uint) {
        return loanNumber;
    }

    function setLoanNumber(uint newLoanNumber) external onlyAdmin {
        loanNumber = newLoanNumber;
    }

    function setLoanType(string calldata newLoanType) external onlyAdmin {
        loanType = newLoanType;
    }

    function setNextStatementDate(
        string calldata newNextStatementDate
    ) external onlyAdminOrServicer {
        nextStatementDate = newNextStatementDate;
    }

    function setOccupancy(
        string calldata newOccupancy
    ) external onlyAdminOrServicer {
        occupancy = newOccupancy;
    }

    function setPrevStatementDate(
        string calldata newPrevStatementDate
    ) external onlyAdminOrServicer {
        prevStatementDate = newPrevStatementDate;
    }
}
