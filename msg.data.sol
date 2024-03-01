// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Demo{
    bytes public inputData1;
    bytes public inputData2;

    fallback (bytes calldata input)external returns(bytes memory output){
        inputData1=input;
        inputData2=msg.data;//input 等于msg.data
        return input;
    }
}