// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./FinancialInstrument.sol";

contract Debt is FinancialInstrument {
    string public accrualDayCountDay;
    string public accrualDayCountPeriod;
    bool public active;
    address public adjustableRateId;
    string public amortizationType;
    address public borrowerId;
    address public collateralId;
    uint public escrowRecurring;
    address public guarantorId;
    address public insurerId;
    uint public interestRate;
    address public lenderId;
    string public maturityDate;
    string public nextRateDate;
    string public originationDate;
    uint public paymentRecurring;
    uint public paymentsPerYear;
    uint public precisionInterest;
    uint public principal;
    string public prevRateDate;
    string public rateType;
    address public servicerId;
    uint public term;

    modifier onlyAdminOrServicer() {
        require(
            msg.sender == adminId || msg.sender == servicerId,
            "Only Admin or Servicer can call this function"
        );
        _;
    }

    modifier onlyBorrower() {
        require(
            msg.sender == borrowerId,
            "Only Borrower can call this function"
        );
        _;
    }

    modifier onlyCollateral() {
        require(
            msg.sender == collateralId,
            "Only Collateral can call this function"
        );
        _;
    }

    modifier onlyGuarantor() {
        require(
            msg.sender == guarantorId,
            "Only Guarantor can call this function"
        );
        _;
    }

    modifier onlyInsurer() {
        require(msg.sender == insurerId, "Only Insurer can call this function");
        _;
    }

    modifier onlyServicer() {
        require(
            msg.sender == servicerId,
            "Only Servicer can call this function"
        );
        _;
    }

    constructor() FinancialInstrument() {}

    // SETTERS: ENABLE PERMISSIONED USERS TO UPDATE THE STATE OF THE LOAN
    function setAccrualDayCountDay(
        string calldata newAccrualDayCountDay
    ) external onlyAdmin {
        accrualDayCountDay = newAccrualDayCountDay;
    }

    function setAccrualDayCountPeriod(
        string calldata newAccrualDayCountPeriod
    ) external onlyAdmin {
        accrualDayCountPeriod = newAccrualDayCountPeriod;
    }

    function setActive(bool newActive) external onlyAdmin {
        active = newActive;
    }

    function setAdjustableRateId(
        address newAdjustableRateId
    ) external onlyAdmin {
        adjustableRateId = newAdjustableRateId;
    }

    function setAmortizationType(
        string calldata newAmortizationType
    ) external onlyAdmin {
        amortizationType = newAmortizationType;
    }

    function setBorrowerId(address newBorrowerId) external onlyAdmin {
        borrowerId = newBorrowerId;
    }

    function setCollateralId(address newCollateralId) external onlyAdmin {
        collateralId = newCollateralId;
    }

    function setEscrowRecurring(uint newEscrowRecurring) external onlyAdmin {
        escrowRecurring = newEscrowRecurring;
    }

    function setGuarantorId(address newGuarantorId) external onlyAdmin {
        guarantorId = newGuarantorId;
    }

    function setInsurerId(address newInsurerId) external onlyAdmin {
        insurerId = newInsurerId;
    }

    function setInterestRate(uint newInterestRate) external onlyAdmin {
        interestRate = newInterestRate;
    }

    function setLenderId(address newLenderId) external onlyAdmin {
        lenderId = newLenderId;
    }

    function setMaturityDate(
        string calldata newMaturityDate
    ) external onlyAdminOrServicer {
        maturityDate = newMaturityDate;
    }

    function setNextRateDate(
        string calldata newNextRateDate
    ) external onlyAdminOrServicer {
        nextRateDate = newNextRateDate;
    }

    function setOriginationDate(
        string calldata newOriginationDate
    ) external onlyAdminOrServicer {
        originationDate = newOriginationDate;
    }

    function setPaymentRecurring(
        uint newPaymentRecurring
    ) external onlyAdminOrServicer {
        paymentRecurring = newPaymentRecurring;
    }

    function setPaymentsPerYear(uint newPaymentsPerYear) external onlyAdmin {
        paymentsPerYear = newPaymentsPerYear;
    }

    function setPrecisionInterest(
        uint newPrecisionInterest
    ) external onlyAdmin {
        precisionInterest = newPrecisionInterest;
    }

    function setPrincipal(uint newPrincipal) external onlyAdmin {
        principal = newPrincipal;
    }

    function setPrevRateDate(
        string calldata newPrevRateDate
    ) external onlyAdminOrServicer {
        prevRateDate = newPrevRateDate;
    }

    function setRateType(
        string calldata newRateType
    ) external onlyAdminOrServicer {
        rateType = newRateType;
    }

    function setServicerId(address newServicerId) external onlyAdmin {
        servicerId = newServicerId;
    }

    function setTerm(uint newTerm) external onlyAdmin {
        term = newTerm;
    }
}
