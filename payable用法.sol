// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Payable{
    //payable 标记函数 
    //2300gas的限制
    
    function deposit1()external payable{}
    
    function deposit2()external{}
    //payable可以放在funcion上，执行接受以太，
    //放在address,可以向这个地址转钱

    //payable 标记地址
    function withdraw()external{
        payable(msg.sender).transfer(address(this).balance);
    }

    //通过balance 属性，来查看余额
    function getBalance()external view returns(uint256){
        return address(this).balance;
    }
}
