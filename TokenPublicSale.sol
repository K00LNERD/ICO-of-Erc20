// SPDX-License-Identifier: MIT
pragma solidity ^0.8.5;

import "./Copy_Ownable.sol";
import "./transferhelper.sol";
interface Token {
    function balanceOf( address a) external view returns (uint256);
    function decimals() external view returns (uint256);
    function transferFrom(address _from, address _to, uint256 _value) external view returns (bool);
    
}
interface oracleInterface {
    function latestAnswer() external view returns (int256);
    function decimals() external view returns (uint8);
}


contract TokenPublicSale is Ownable{
    // using SafeMath for uint256;
    
    uint256 decimalFactor;
    uint256 amountInUSD;
    uint256 public tokenPrice= 1 ;// in 10**2..
    uint256 tokenSold;
    
   
    address public BUSDOracleAddress=0x8A753747A1Fa494EC906cE90E9f37563A8AF630e;
    event BuyTokenEvent(address indexed userAdress, uint256 tokenAmount);
    
    mapping(address => bool) isRegistered;

    address tokenAddr;
    
    constructor(address _token){
        tokenAddr = _token;
        decimalFactor=10**Token(tokenAddr).decimals();
        
    }
    
    function buyTokens() external payable returns (uint256){
        
        amountInUSD=(uint256)(oracleInterface(BUSDOracleAddress).latestAnswer());
        uint256 noOfTOkens = (msg.value*amountInUSD*decimalFactor)/(10**26);
        require(noOfTOkens<=Token(tokenAddr).balanceOf(address(this)),"Not enough tokens available to buy.");


            TransferHelper.safeTransfer(tokenAddr,msg.sender, noOfTOkens ); 
            //  address a = payable(msg.sender);
           
            emit BuyTokenEvent(msg.sender,noOfTOkens);
            
            return noOfTOkens;
    }

    function tokenLeft() external view returns(uint256){
        return (Token(tokenAddr).balanceOf(address(this)));
    }
}
