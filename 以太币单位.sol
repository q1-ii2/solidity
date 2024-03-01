// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

//全局的以太币单位
//1. 'wei','gwei','ether'
//-最小单位wei/
//-1ETHE=10**18

contract Demo{
    function test() public pure returns (bool a,bool b,bool c){
        a=1 wei==1;
        b=1 gwei==1e9;
        c=1 ether==1e18;
    }
}

contract Demo2{
    uint256 public amount;

    constructor(){
        amount=1;
    }

    function fnEth()public view returns(uint256){
        return amount+1 ether; //1000000000000000001
    }

    function fnGwei()public view returns(uint256){
        return amount+1 gwei; //1000000001
    }

    //这些后缀不能直接用在变量后边，如果想用以太币单位来计算输入参数
    //，你可以用如下方式来完成
    function testVar(uint256 amountEth)public view returns(uint256){
        return amount + amountEth * 1 ether;
    }
}