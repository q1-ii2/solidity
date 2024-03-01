// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

//0x1c91347f2A44538ce62453BEBd9Aa907C662b4bD
contract StoneCat{
    uint256 public age=0;
    event eventFallback(string);

    //发送到这个合约的所有消息都会调用此函数(因为该合约没有其他函数)
    //想这个合约发送以太币会导致异常,因为fallback函数没有 payable修饰符
    fallback()external{
        age++;
        emit eventFallback("fallback");
    }
}

interface AnimalEat{
    function eat() external returns (string memory);
}

contract Animal{
    //StoneCat address
    function test1(address _addr)external returns (string memory){
        AnimalEat general = AnimalEat(_addr);
        return general.eat();
    }
    function test2(address _addr)external returns (bool success){
        AnimalEat general = AnimalEat(_addr);
        (success,)=address(general).call(abi.encodeWithSignature("eat()"));
        require(success);
    }
}
