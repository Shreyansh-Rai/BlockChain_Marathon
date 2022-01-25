//SPDX-License-Identifier: MIT
//This stops the compiler from pestering you to give the License identifier.

pragma solidity >=0.6.0 <0.9; //Sets the version of the solidity compiler.
import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";
//To consume price data, your smart contract should reference AggregatorV3Interface, which defines the external functions implemented by Data Feeds.
contract FundMe{
    mapping(address => uint256) public addressValueMap;
    address public owner;
    address[] public funders;
    constructor() public {
        owner = msg.sender;
    }
    function fund() public payable{
        uint256 min = 5;
        require(getConverted(msg.value) >= min,"Aur paisa de na");
        //So here basically require is an if and revert if the condition fails
        //So in this case if we get less than 50 USD we will revert the amount payed back to payer and stop exec
        addressValueMap[msg.sender] += msg.value;
        funders.push(msg.sender);
        // this msg.sender and msg.value are built in.
    }
    function getVersion() public view returns(uint256){
        AggregatorV3Interface av3 = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        //So remember you kinda do this to get back the contract into a variable so you can do your func calls
        //and this address over here points to a contract that is going to have the usd eth data conversions.
        return av3.version();
    }

    function getPrice() public view returns(uint256){
        AggregatorV3Interface av3 = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        (,int256 answer,,,) = av3.latestRoundData();
        return uint256(answer);
    }
    function getConverted(uint256 ethamt) public view returns(uint256)
    {
        uint256 ethPrice = getPrice();
        uint256 inUSD = ethPrice * ethamt / 10**18;
        return inUSD;
    }
    modifier onlyOwner
    {
        require(msg.sender==owner);
        _;
    }
    function withdraw() public onlyOwner payable {
        // require(msg.sender == owner);
        msg.sender.transfer(address(this).balance);
        // here this is reffereing to the address of this contract

        //now since the owner has taken all the eth from this contract we can update the values in the funder list
        for( uint256 i=0;i<funders.length;i++)
        {
            address funder = funders[i];
            addressValueMap[funder] = 0;
        }
        funders = new address[](0);
    }
}
