//SPDX-Licence-Identifier:MIT
pragma solidity ^0.8.14;

contract Math{
    bytes1 num1=0x12;
    bytes4 num2=0x12121212;

    function getLength1()public view returns(uint8){
        return num1.length;
    }

    function getLength2()public view returns(uint8){
        return num2.length;
    }
}




contract DynamicByte{

  string name="linghu";

  function getLength() public view returns(uint){
       return bytes(name).length;//通过byte强制转换获取长度
  }

  function changename() public view returns(bytes1){
       return bytes(name)[1];
  }
  function getName() public view returns(bytes memory){
       return bytes(name);
  }


}
