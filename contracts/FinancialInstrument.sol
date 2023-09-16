// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract FinancialInstrument {
    address public adminId;
    string public currency;
    address public investorId;
    string public language;
    string public locale;
    uint public precisionCurrency;
    address public sContractAddress;
    address public sContractId;
    uint public sContractVersion;
    address public topicId;

    modifier onlyAdmin() {
        require(msg.sender == adminId, "Only Admin can call this function");
        _;
    }

    modifier onlyInvestor() {
        require(
            msg.sender == investorId,
            "Only Investor can call this function"
        );
        _;
    }

    constructor() {
        adminId = msg.sender;
        investorId = msg.sender;
        sContractAddress = address(this);
    }

    function setAdminId(address newAdminId) external onlyAdmin {
        adminId = newAdminId;
    }

    function setCurrency(string calldata newCurrencyPeriod) external onlyAdmin {
        currency = newCurrencyPeriod;
    }

    function setInvestorId(address newInvestorId) external onlyAdmin {
        investorId = newInvestorId;
    }

    function setLanguage(string calldata newLanguage) external onlyAdmin {
        language = newLanguage;
    }

    function setLocale(string calldata newLocale) external onlyAdmin {
        locale = newLocale;
    }

    function setPrecisionCurrency(
        uint newPrecisionCurrency
    ) external onlyAdmin {
        precisionCurrency = newPrecisionCurrency;
    }

    function setSContractAddress(
        address newSContractAddress
    ) external onlyAdmin {
        sContractAddress = newSContractAddress;
    }

    function setSContractId(address newSContractId) external onlyAdmin {
        sContractId = newSContractId;
    }

    function setSContractVersion(uint newSContractVersion) external onlyAdmin {
        sContractVersion = newSContractVersion;
    }

    function setTopicId(address newTopicId) external onlyAdmin {
        topicId = newTopicId;
    }
}
