// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

contract Hello {
    //3433
    string public message = "Hello World!"; //状态变量

    /*
    */
    //函数
    //3397
    function fn1() public view returns (string memory){
        return message;
    }
                        //pure修改状态变量
    //728,内存中直接返回
    function fn2()public pure returns(string memory){
        return "Hello World";
    }
    //807
    function fn3()public pure returns(string memory){
        return fn2();
    }
}
