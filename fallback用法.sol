// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

    //fallback
    //-语法:
    //  fallback()external [payable]
    //  fallback(bytes calldata input) external [payable] returns(bytes memory output)
    //  msg.data 可以通过abi.decode([4:]) 解码
    //-回退函数在两种情况被调用
    //  -向合约转账
    //  -执行合约不存在的方法
    //-带参数的fallback

    contract Payable{
        event Log(string funName,address from,uint256 value,bytes data);

        function deposit() external payable{}

        //通过balance属性,来查看余额
        function getBalance() external view returns (uint256){
            return address(this).balance;
        }

        fallback()external payable{
            emit Log("fallback",msg.sender,msg.value,msg.data);
        }
    }