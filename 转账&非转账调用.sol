// SPDX-Licence-Identifier:MIT
pragma solidity ^0.8.17;

//这个合约会保留所有发送给他的以太币，没有办法返还。
contract Demo{
    uint256 public x;
    uint256 public y;

    event Log(string funName, address from,uint256 value, bytes data);

    //纯转账调用这个函数，例如对每个空empty calldata的调用
    receive()external payable{  //2300
        x=1;
        y=msg.value;
        emit Log("receive",msg.sender,msg.value,"");
    }

    //除了存转账外，所有的调用都会调用这个函数
    //(因为除了 Receive函数外，没有其他的函数)。
    //任何对合约非空calldata 调用会执行回退函数(即使是调用函数附加以太)。
    fallback()external payable{
        x=2;
        y=msg.value;
        emit Log("fallback",msg.sender,msg.value,msg.data);
    }

    function getBalance() external view returns (uint256){
        return address(this).balance;
    }
}