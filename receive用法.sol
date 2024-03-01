//SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

//receive:只负责接受主币
//  -receive() external payable{}
//  -payable是必要的
//  -没有function关键字  
//receive和fallback共存的调用 都可以被重载调用

 contract Demo{
    event Log(string funName,address from,uint256 value,bytes data);

    receive()external payable{
        //receive 被调用的时候不存在 msg.data 所以不使用这个，直接用空字符串
        emit Log("receive",msg.sender,msg.value,"");
    }

    fallback()external{}

    function getBalance()external view returns(uint256){
        return address(this).balance;
    }
 }
    //通过calldata的转账调用会触发receive，如果有参数的话会报错，说没有fallback函数