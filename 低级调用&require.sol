// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract StoneCat{
    uint256 public age=0;
    bytes public inputData1;
    bytes public inputData2;
    uint256 public c;
    uint256 public d;

    event eventFallback(string);

    fallback(bytes calldata input)external returns(bytes memory output){
        age++;
        inputData1=input;
        inputData2=msg.data;
        (c,d)=abi.decode(msg.data[4:],(uint256,uint256));
        emit eventFallback("fallbak");
        return input;
    }
}

interface AnimalEat{
    function eat() external returns (string memory);
}

contract Animal{
    function test2(address _addr)external returns(bool success){
        AnimalEat general=AnimalEat(_addr);
        (success,)=address(general).call(abi.encodeWithSignature("eat()",123,456));
        require(success);
    }
}