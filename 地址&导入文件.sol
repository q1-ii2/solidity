// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Demo1{
    //this 本身代表当前的合约

    //address(this)
    function fn1() external view returns(address){
        return address(this);//当前的合约地址
        //0xd8b934580fcE35a11B58C6D73aDeE468a2833fa8 返回的值
        //0xd8b934580fcE35a11B58C6D73aDeE468a2833fa8 部署地址
    }

    //this.fn1()
    function fn2() external view returns(address){
        return this.fn1(); // external 方法的调用
    }
}

//合约地址/合约创建者地址/合约调用者地址
contract Demo2{
    address public owner1; //0x7EF2e0048f5bAeDe046f6BF797943daF4ED8CB47
    address public owner2; //0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
    address public owner3;

    constructor (){ //constructor只执行过一次
    //owner2在部署的时候已经确定了地址,所以并不会随着调用者的改变而改变
        // owner = msg.sender;
        owner1 = address(this); // 合约地址
        owner2 = msg.sender;
    }

// 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
// 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
// 谁调用，msg.sender就是谁
    function fn() public  view returns(address){
        return msg.sender;
    }
}


// contract Hello{
//     string public message="Hello World!";
// }

//import作用就是导入文件
import "./hello.sol"; //本地导入
// import "https://github.com/xxxxx"; //导入网络文件：https://github.com/xxxxx
// import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

//遇到冲突的时候
import * as aaa from "./hello.sol";
import "./hello.sol"as aaaa; //本地导入

//3.按需导入
// import{symbol1 as aliasName, sybol2}from "filename";

contract Demo3{
    function name()public pure returns(string memory){
        return type(Hello).name;
    }
    //表示合约的字节码
    function creationCode()public pure returns(bytes memory){
        return type(Hello).creationCode;
    }
    //获取合约运行时的字节码
    function runtimeCode()public pure returns(bytes memory){
        return type(Hello).runtimeCode;
    }
}