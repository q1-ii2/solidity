// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
pragma solidity >=0.8.17<0.9.0;//等价于‘^0.8.17’
pragma solidity >=0.7.0<0.9.0;
// pragma solidity 0.8.17; //指定版本


// NetSpec 描述注释

///@title 一个简单的数据存储演示
///@author Qi_1
///@notice 您智能将此合约用去最基本的演示
///@dev 提供了存储方法/获取方法
///@custom:xxxx     自定义的描述/这个是实验的测试合约
//contract是一个合约 名字是TingStorage 合约一般都是大驼峰
contract TingStorage{
    //data
    //storedData是状态变量
    uint256 storedData;

    /// @notice 储存 x
    /// @param _x: storedData 将要修改的值
    /// @dev   将数字存储在状态变量 storedData中
    function set(uint256 _x)public{
        storedData=_x;
    }

    ///@notice 返回存储的值
    ///@return 储存值
    ///@dev   检索状态变量 storedData的值
    function get() public view returns(uint256){
        return storedData;
    }

    /**
     * @notice 第二种写法
     * @param _x: XXXX
     * @dev   XXXX
     * @return XXXX
     * @inheritdoc:
    */
}