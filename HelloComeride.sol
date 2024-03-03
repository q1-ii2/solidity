//SPDX-Licence-Identifier:MIT
pragma solidity ^0.8.14;

///@title 一个模拟同志们好的简单演示
///@author Qi_1
///@notice 您只能将此合约用于最基本的模拟演示
///@dev 本章主要内容的实战演习
///@custom:xxxx  experimental 这是实验的合约
contract HelloComrades{

    ///@notice 当前进度的标记
    //@dev 0:等待领导说"同志们好
    //@dev 1:等待同志们回复"领导好"
    //@dev 2:等待领导说"同志们辛苦啦"
    //@dev 3:等待同志们回复"为人民服务"
    //@dev 4:等待销毁合约
    //@return 当前的进度
    uint8 public step=0;
    address public immutable leader;

    string internal constant UNKNOWN = unicode"我不知道如何处理它,你找有关部门吧!";

    ///@notice 用于当前step被修改的通知
    ///@dev     只要合约的step发生变化 都会抛出此事件
    ///@param   当前最新的step
    event Step(uint8);

    /// @notice 金额变动的同志
    /// @dev   只要合约的余额发生变化,都抛出此事件
    /// @param tag  标记内容
    /// @param from 当前地址
    /// @param value 当前发送金额
    /// @param data 当前调用的data内容
    event Log(string tag,address from,uint256 value,bytes data);


    ///@notice 检查只能领导调用
    ///@dev 用于领导使用的函数
    modifier onlyLeader(){
        require(msg.sender==leader,unicode"必须领导才能说");
        _;
    }


    ///@notice 检查只能非领导调用
    ///@dev 用于领导使用的函数
    modifier notLeader(){
        require(msg.sender!=leader,unicode"领导不能说");
        _;
    }


    /*
    *========================================
    *Errors
    *========================================
    */

    ///@notice 自定义错误
    ///@dev     所有的已知错误

    ///这是一个自定义的错误,上方需要空一行
    error MyError(string msg);

    /*
    *========================================
    *Constructor
    *========================================
    */

    constructor(address leader_){
        require(leader_ !=address(0),"invalid address");
        leader = leader_;
    }

    /*
    *========================================
    *Functions
    *========================================
    */

    ///@notice  用于领导说"同志们好"
    ///@dev     只能在step为0的时候调用,只能领导调用,并且只能说"同志们好"
    ///@param content:  当前领导说的内容
    ///return   当前的调用状态,true为成功

    function hello(string calldata content)external onlyLeader returns(bool){
         if(step!=0){
            revert(UNKNOWN);
        }
        if(!review(content,unicode"同志们好")){
            revert MyError(unicode"必须说:同志们好");
        }
        step=1;
        emit Step(step);
        return true;
    }

    ///@notice  用于同志们说"领导好"
    ///@dev     只能在step为1的时候调用,只能同志们调用,并且只能说"领导好"
    ///@param content:  当前同志们说的内容
    ///return   当前的调用状态,true为成功
    function helloRes(string calldata content)external notLeader returns(bool){
       if(step!=1){
            revert(UNKNOWN);
        }
        if(!review(content,unicode"领导好")){
            revert MyError(unicode"必须说:领导好");
        }
        step=2;
        emit Step(step);
        return true;
    }

    ///@notice  用于领导说"同志们辛苦啦"
    ///@dev     只能在step为2的时候调用,只能领导调用,并且只能说"同志们辛苦啦"
    ///@param content:  当前领导说的内容
    ///return   当前的调用状态,true为成功
    function comfort(string calldata content)external payable notLeader returns(bool){
       if(step!=2){
            revert(UNKNOWN);
        }
        if(!review(content,unicode"同志们辛苦啦")){
            revert MyError(unicode"必须说:同志们辛苦啦");
        }

        if(msg.value < 2 ether){
            revert MyError(unicode"给钱！最少给两个以太币");
        }
        step=3;
        emit Step(step);
        return true;
    }

    /*
    *========================================
    *Helper
    *========================================
    */

    function review(string calldata content,string memory correctContent)
    private
    pure
    returns(bool){
        return keccak256(abi.encodePacked(content))==keccak256(abi.encodePacked(correctContent));
    }
    
    receive() external payable{
        emit Log("receive",msg.sender,msg.value,"");
    }

    fallback() external payable{
        emit Log("receive",msg.sender,msg.value,msg.data);
    }    

    /// @notice 用来获取当前合约的余额
    /// @dev    一个当前合约金额的辅助函数
    /// @return 当前合约的余额
    function getBalance()external view returns(uint256){
        return address(this).balance;
    }
}
