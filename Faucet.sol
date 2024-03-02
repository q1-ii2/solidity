//SPDX:Licence-Identifier:MIT
pragma solidity ^0.8.14;

contract Faucet{
    receive() external payable {}
    function withdraw(uint amount)public payable{
        require(amount<=1000000000000000000);
        payable(msg.sender).transfer(amount);
    }
}