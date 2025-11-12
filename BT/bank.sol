// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;
contract Bank {
    mapping(address => uint) private balances;
    
    // Constructor - automatically credits deployer with initial ETH sent
    constructor() payable {
        if(msg.value > 0) {
            balances[msg.sender] = msg.value;
        }
    }
    
    // 1. Deposit money - just send ETH with the transaction
    function deposit() public payable {
        require(msg.value > 0, "Must send ETH with transaction");
        balances[msg.sender] += msg.value;
    }
    
    // 2. Withdraw money - enter amount in ETH (e.g., 5 for 5 ETH)
    function withdraw(uint amountInEth) public {
        require(amountInEth > 0, "Amount must be greater than 0");
        uint amountInWei = amountInEth * 1 ether;
        require(balances[msg.sender] >= amountInWei, "Insufficient balance");
        balances[msg.sender] -= amountInWei;
        payable(msg.sender).transfer(amountInWei);
    }
    
    // 3. Show balance - returns balance in ETH (not Wei)
    function getBalance() public view returns (uint) {
        return balances[msg.sender] / 1 ether;
    }
}