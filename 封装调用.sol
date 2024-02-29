// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Cat {
    uint256 public age;

    function eat() public returns (string memory){
        age++;
        return "cat eat fish";
    }

    function sleep1() public pure returns (string memory){
        return "sleep1";
    }
}

contract Dog {
    uint256 public age;

    function eat() public returns (string memory){
        age+=2;
        return "dog eat meat";
    }

    function sleep2() public pure returns (string memory){
        return "sleep2";
    }
}

//可以利用接口对不同合约进行中转
interface AnimalEat{
    function eat()external returns(string memory);
}


library Set{
    struct Data{mapping(uint => bool)flags;}
    function test() external pure returns(uint256){
    return 111;
    }
}

contract Animal{
    function test(address _addr) external returns (string memory){
        AnimalEat general =AnimalEat(_addr);
        return general.eat();
    }
    //这个函数 interfaceId 返回了 AnimalEat 接口的 ID。
    //在 Solidity 中，接口 ID 是接口函数的签名的哈希值，用于标识接口。
    function interfaceId() external pure returns(bytes4){
        return type(AnimalEat).interfaceId;
    }
    function testA() external pure returns(uint256){
        return Set.test();
    }
}