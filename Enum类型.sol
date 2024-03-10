//SPDX:License-Identifier:MIT
pragma solidity ^0.8.14;

// enum是一种用户自定义类型,用于表示多种状态
//  -主要作用是用于限制某个事物的有限选择.比如将咖啡的容量大小限制为:大,中,小,
//  -这将确保任何人不能购买其他容量的咖啡,只能在这里选择
//-枚举类型,返回值是索引,默认值是0;
//-枚举类型的默认值是第一个值
//  -枚举类型 enum 至少应该有一名成员
//-枚举不能多于256个成员
//      -枚举默认的类型为uint8,当枚举数足够多时,他会自动变成 uint16..等变大
//      -可以通过remix部署后,函数的输入值内查看uint8/uint16
contract Enum{
    //枚举类型的默认值是第一个值
    //结果
    enum Status{
        None,
        Pending,
        Shiped,
        Completed,
        Rejected,
        Canceled
    }
    //变量
    Status public status;

    //设置索引值
    function set(Status _status)external{
        status=_status;
    }

    //由于枚举类型不属于|ABI|的一部分,因此对于所有来自Solidity外部的调用
    //"getStatus"的签名会自动被改成"getStatus() returns (uint8)".
    function getStatus() public view returns(Status){
        return status;
    }

    function getDefaultStatus() public view returns (uint256){
        return uint256(status);
    }

    //设置
    function ship() external{
        status = Status.Shiped;
    }

    //恢复为0
    function reset() external{
        delete status;
    }
}