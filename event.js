var abi = /* abi as generated by the compiler */;
let abi = JSON.parse(build.contracts.Propertyf.json);
var Property = webs.eth.contract(abi, contract);
var contract = Property.at("" /* address of the contract*/);
var owneraddress = "0xe104eBAF714e3E611366b72C31e55905416603DD";
//const user = web3.eth.accounts[0];
var web3 = new Web3();
web3.setProvider(new web3.providers.HttpProvider('http://localhost:8545'));

//event for alloted property
var event = contract.PropertyAlloted();

event.watch(function(err, res){
	//result wiil contain various information
	//including the arguments given to the Transfer call

	if(!err){
		console.log(res);
	} else {
		console.log(err);
	}
});

// Or pass a callback to start watching immediately
var event2 = contract.PropertyTransferred(function(error, result) {
    if (!error){
        console.log(result);
    } else {
    	console.log(error);
    }
});


//get all properties from ethereum
var properties = function(err, res{});

//count of properties registered
var count = contract.getPropertyCountOfAnyAddress.call(owneraddress, function(err, res{
	if(err){
		console.log(err);
	} else {
		console.log(res);
	})
});

//method for transfer of property when button transfer is clicked
contract.transferProperty(address _to, string _propertyName, string _propertyLocation);

