//SPDX-License-Identifier: MIT
//This stops the compiler from pestering you to give the License identifier.

pragma solidity ^0.6.0; //Sets the version of the solidity compiler.

contract SimpleStorage
{
    struct People
    {
        string name;
        uint256 number;
    }
    People[] public people;
    uint256 public mynum;
    //the variables if public are visible on the chain other wise by default they are internal.
    //You can also have private and external variables external btw is just variables that 
    //must be called from outside this contract.

    mapping(string=>uint256) public nametonum;
    function store(uint256 xyz) public returns(uint256)
    {
        mynum = xyz;
        return mynum;
    }
    function watch () public view returns(uint256)
    {
        return mynum;
    }
    function addpeople(string memory _name, uint256 _num) public 
    {
        people.push(People(_name,_num));
        nametonum[_name] = _num;
    }
    //memory is a way to keep the string that is being passed in the memeory as long as the function is actually being used.
    //useful for temporary usages like assigning the value of the passed string to someother variable or putting on the block chain.
}