//SPDX-License-Identifier: MIT
//This stops the compiler from pestering you to give the License identifier.

pragma solidity ^0.6.0;
import "./SimpleStorage.sol";
//Or you could just say StorageFactory is SimpleStorage and that is like inheritance so 
//You can directly use all that stuff and all functions and everything
contract SimpleStorageFactory
{
    SimpleStorage[] public array;
    function createSimpleStorage () public {
        SimpleStorage ss = new SimpleStorage();
        array.push(ss);//Pushing the contract into an array calling an array index will return an address.
        //Passing that into an address() and into the Contract will result in a sort of pointer to that
        //Contract that you are able to modify as shown below
    }
    function store(uint256 index, uint256 number) public {
        SimpleStorage ss = SimpleStorage(address(array[index]));
        ss.store(number);
    }
    function getStored(uint256 index) public  view returns (uint256) {
        SimpleStorage ss = SimpleStorage(address(array[index]));
        return ss.watch();
    } 
}
