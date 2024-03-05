pragma solidity ^0.8.14;
//所有人都可以存钱
//ETH
//只有合约owner才可以取钱
//只要取钱,合约就销毁掉
//拓展:支持主币以外的资产
// -ERC20
// -ERC721

//存钱罐合约:多次存,一次取,取完就销毁
contract Bank{
  address public immutable owner;

    event Deposit(address _ads,uint256 amount);
    event Withdraw(uint256 amount);

    receive()external payable{
        deposit();
    }

  constructor(){
    //0x5B38Da6a701c568545dCfcB03FcB875f56beddC4  =>85.9 =>108.9
    owner=msg.sender;
  }

  function withdraw()external{
    require(msg.sender==owner,"Not owner address");
    emit Withdraw(address(this).balance);
    selfdestruct(payable(msg.sender));
  }

  function deposit()public payable{
    emit Deposit(msg.sender,msg.value);
  }

  function getBalance()external view returns(uint256){
    return address(this).balance;
  }
}