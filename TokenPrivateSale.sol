// SPDX-License-Identifier: MIT
pragma solidity ^0.8.5;   
    import "./Copy_Ownable.sol";
    interface Token {
    function balanceOf( address a) external view returns (uint256);
    function decimals() external view returns (uint256);
    function transferFrom(address _from, address _to, uint256 _value) external view returns (bool);
    
}
    
    contract privateSale{
    mapping(address => bool) isRegisteredf;
    mapping(address => bool) isRegisteredn;
    mapping(address => bool) isRegisteredc;
    address tokenAddr;
    uint256 decimalFactor;
    uint256 noOfTokenperf = 100000; 
    uint256 noOfTokenpern = 100000; 
    uint256 noOfTokenperc = 100000; 
    address owner;
    
    
    constructor( address _token){
        tokenAddr = _token;
        decimalFactor=10**Token(tokenAddr).decimals();
        owner = msg.sender;
    }
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }
    
    function registerAsFamily(address addr) external view onlyOwner{
        uint256 i=0 ;
        require(!isRegisteredf[addr], "This address is already registered as family.");
        require (i<=19,"no more members can be registered");
        isRegisteredf[addr];
        i+=1;
    }
    
    function registerAsFriends(address addr) external view{
        uint256 i = 0;
        require (!isRegisteredn[addr],"This address is already registered as Friends");
        require (i<=14,"no more members can be registered");
        isRegisteredn[addr];
        i+=1;
    }
    
    function registerAsColleague(address addr) external view{
        uint256 i;
        require (!isRegisteredc[addr],"This address is allready register as colleague");
        require (i<=14,"no more members can be registered");
        isRegisteredc[addr];
        i+=1;
    }
    
    function claim() external view{
        if(isRegisteredf[msg.sender]){
            Token(tokenAddr).transferFrom(address(this),msg.sender, noOfTokenperf);
        }
        if(isRegisteredn[msg.sender]){
            Token(tokenAddr).transferFrom(address(this),msg.sender, noOfTokenpern);
        }
        if(isRegisteredc[msg.sender]){
            Token(tokenAddr).transferFrom(address(this),msg.sender, noOfTokenperc);
        }
        
    }
}
