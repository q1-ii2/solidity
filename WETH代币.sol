//SPDX-Lience-Identifier:MIT
pragma solidity ^0.8.14;

//WETH代币，是包装ETH主币，作为ERC20的合约
//转换金额要匹配
//-deposit：10 ETH => 10 WETH
//-witchdrop：10 WETH => 10 ETH
//-WETH需要遵守ERC20标准

//标准的ERC20合约包括如下几个

//3个查询
//-balanceOf: 查询指定地址的Token数量
//-allowance: 查询指定地址对另一个地址的剩余授权额度
//-totalSupply: 查询当前合约的 Token 总量
//2个交易
//-transfer:从当前调用者地址发送指定数量的Token到指定地址
//-这是一个写入方法,所以还会抛出一个 Transfer 事件
//-transferFrom: 当向另外一个合约地址存款时,对方合约必须调用transferFrom才可以把Token
//拿到他自己的合约中
//2个事件
//-Transfer
//-Approval
//1个授权
//approve:授权指定地址可以操作调用者的最大 Token 数量

contract ETH{
    string public constant name="Wrapped Ether";
    string public constant symbol="WETH";
    uint8 public constant decimals=18;

    //event 事件
    event Approval(address indexed src,address indexed delegateAds,uint256 amount);
    event Transfer(address indexed src,address indexed delegateAds,uint256 amount);
    event Deposit(address indexed src, uint256 amount);
    event Withdraw(address indexed src,uint256 amount);

    //映射
    mapping (address=>uint256)public balanceOf;
    mapping(address=>mapping(address=>uint256))public allowance; 

    function deposit() public payable{
        balanceOf[msg.sender]+=msg.value;
        emit Deposit(msg.sender,msg.value);
    }

    function withdraw(uint256 amount_)public payable{
        //取钱的逻辑
        require(balanceOf[msg.sender]>=amount_,"error amount"); //检测
        balanceOf[msg.sender]-=amount_; //写状态变量
        payable(msg.sender).transfer(amount_);// 真正的操作
        emit Withdraw(msg.sender,msg.value);
    }

    function totalSupple()public view returns(uint256){
        return address(this).balance;
    }

    function approve(address delegateAds_,uint256 amount_)public returns(bool){
        allowance[msg.sender][delegateAds_]=amount_;
        emit Approval(msg.sender,delegateAds_,amount_);
        return true;
    }

    function tranfer(address toAds_,uint256 amount_)public returns(bool){
        return transferFrom(msg.sender,toAds_,amount_);
    }
    
    function transferFrom(address src,address toAds_,uint256 amount_)public returns(bool){
        require(balanceOf[src]>=amount_,"error amount");

        if(src != msg.sender){
            require(allowance[src][msg.sender] >= amount_);
            allowance[src][msg.sender] -= amount_;
        }
        balanceOf[src] -= amount_;
        balanceOf[toAds_] += amount_;
        emit Transfer(src,toAds_,amount_);
        return true;
    }

    receive() external payable{
        deposit();
    }
}