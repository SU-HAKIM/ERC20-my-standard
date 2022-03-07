//SPDX-License-Identifier: UNLICENSED

pragma solidity >= 0.5.0 < 0.9.0;

contract ERC20{
    string name;
    //In started docs name is specified as a function.In my case i am making it a public variable so that a getter function can be created automaticaly
    string symbol;
    //Same as name
    uint8 decimals;
    //Same as name
    uint256 totalSupply;
    //Same as name

    mapping(address=>uint256) public balanceOf;
    //Same as name but it is a public mapping.
    mapping(address=>mapping(address=>uint256)) public allowance;
    //same as balanceOf

    event Transfer(
        address indexed _from,
        address indexed _to,
        uint256 _value
    );
    event Appoval(
        address indexed _owner,
        address indexed _spender,
        uint256 _value
    );

    constructor(uint256 _totalSupply){
        name="ERC20";
        symbol="HK";
        decimals=18;
        totalSupply=_totalSupply;
        balanceOf[msg.sender]=_totalSupply;
    }

    function transfer(address _to,uint256 _value) public returns(bool success){
        require(balanceOf[msg.sender] >= _value);

        balanceOf[msg.sender]-=_value;
        balanceOf[_to]+=_value;

        emit Transfer(msg.sender, _to, _value);

        return true;
    }

    function approve(address _spender,uint256 _value) public returns(bool success){
        require(balanceOf[msg.sender]>=_value);
        allowance[msg.sender][_spender]=_value;

        emit Appoval(msg.sender, _spender, _value);

        return true;
    }

    function transferFrom(address _from,address _to,uint256 _value) public returns(bool success){
        require(allowance[_from][msg.sender]>=_value);
        require(balanceOf[_from]>=_value);

        balanceOf[_from]-=_value;
        balanceOf[_to]+=_value;

        allowance[_from][msg.sender]-=_value;

        emit Transfer(_from, _to, _value);

        return true;
    }


}

//A => B => 200
//B => A => E => 100