pragma solidity ^0.4.24;

contract Propertyf{
	
	address public da;

	uint256 public totalNoProperty;

	constructor() public{
    	da = msg.sender;
	}

	modifier onlyOwner(){
		require(msg.sender == da);
		_;
	}

	struct Property{
		string name;
		string location;
		bool isSold;
	}

	//address to property
	mapping(address => mapping(uint256 => Property)) public propertiesOwner;

	//mapping of address to the number of properties owned by the address
	mapping(address => uint256) individualCountOfPropertyPerOwner;

	event PropertyAlloted(address indexed _verifiedOwner, uint256 indexed _totalNoOfProperty, string _propertyName, string _propertyLocation, string _msg);
	event PropertyTransferred(address indexed from, address indexed to, string propertyName, string propertyLocation, string _msg);

	function getPropertyCountOfAnyAddress(address _ownerAddress) public constant returns (uint256){

		uint count  = 0;
		for(uint i = 0; i < individualCountOfPropertyPerOwner[_ownerAddress]; i++){
			if(propertiesOwner[_ownerAddress][i].isSold != true){
				count++;
			}
		}
		return count;
	}

	function allotProperty(address _verifiedOwner, string _propertyName, string _location) public  onlyOwner {
		propertiesOwner[_verifiedOwner][individualCountOfPropertyPerOwner[_verifiedOwner]++].name = _propertyName;
		propertiesOwner[_verifiedOwner][individualCountOfPropertyPerOwner[_verifiedOwner]++].location = _location;
		totalNoProperty++;
		emit PropertyAlloted(_verifiedOwner, individualCountOfPropertyPerOwner[_verifiedOwner], _propertyName, _location, "property alloted successfully");
	}

	function isOwner(address _checkOwnerAddress, string _propertyName) public constant returns(uint) {
		uint i;
		bool flag;

		for(i = 0; i < individualCountOfPropertyPerOwner[_checkOwnerAddress]; i++){
			if(propertiesOwner[_checkOwnerAddress][i].isSold != true){
				break;
			}
			flag = stringsEqual(propertiesOwner[_checkOwnerAddress][i].name, _propertyName);
			if(flag == true){
				break;
			}
		}
		if(flag == true){
			return i;
		} else {
			return 99999;
		}
	}

	function stringsEqual(string a1, string a2) private returns (bool){
		return keccak256(a1) == keccak256(a2) ? true : false;
	}

	function transferProperty(address _to, string _propertyName, string _propertyLocation) public returns(bool, uint){
		uint256 checkOwner = isOwner(msg.sender, _propertyName);
		bool flag;
		if(checkOwner != 99999 && propertiesOwner[msg.sender][checkOwner].isSold == false){

			propertiesOwner[msg.sender][checkOwner].isSold = true;
			propertiesOwner[msg.sender][checkOwner].name = "Sold";

			propertiesOwner[_to][individualCountOfPropertyPerOwner[_to]++].name = _propertyName;

			flag = true;

			emit PropertyTransferred(msg.sender, _to, _propertyName, _propertyLocation, "Owner has been changed");

		} else {

			flag = false;
			//emit the event PropertyTransferred
			emit PropertyTransferred(msg.sender, _to, _propertyName, _propertyLocation, "Owner doesn't own the property");
			return(flag, checkOwner);
		}
	}
}
