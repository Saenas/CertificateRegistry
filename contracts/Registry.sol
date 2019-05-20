pragma solidity ^0.5.8;

import './Ownable.sol';

contract Registry is Ownable {
	string public name;

	constructor(string memory _name) public {
		name = _name;
	}	

	event FileRegistered(string indexed registered);
	event FileRemoved(string indexed removed);

	struct FileDetails {
		uint timestamp;
		uint blockNumber;
	}

	mapping (string => FileDetails) registeredFiles;
	mapping (string => FileDetails) removedFiles;

	function registerFile(string memory fileHash) public onlyOwner {
		
	}

	function removeFile(string memory fileHash) public onlyOwner {
		
	}

	function isRegistered(string memory fileHash) public view returns(bool, uint, uint) {
		
	}

	function isRemoved(string memory fileHash) public view returns(bool, uint, uint){
		
	}

	function isValid(string memory fileHash) public returns(bool) {
		
	}
}